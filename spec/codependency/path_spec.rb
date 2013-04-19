require 'spec_helper'

describe Codependency::Path do
  it { should be_an( Array ) }

  describe '#extensions' do
    it 'contains ".rb" by default' do
      subject.extensions.should == [ '.rb' ]
    end
    it 'accepts an array' do
      subject = described_class.new [ '.rb', '.js' ]
      subject.extensions.should == [ '.rb', '.js' ]
    end
    it 'accepts a string and turns it into an array' do
      subject = described_class.new '.js'
      subject.extensions.should == [ '.js' ]
    end
  end

  describe '#<<' do
    it 'turns paths into pathnames' do
      subject << './spec/fixtures'
      subject[ 0 ].should be_a( Pathname )
    end
    it 'expands paths as they are added' do
      subject << './spec/fixtures'
      subject[ 0 ].to_path.should == File.expand_path( './spec/fixtures' )
    end
    it 'raises an exception if the path does not exist' do
      expect { subject << './spec/mixtures' }.to raise_error( Errno::ENOENT )
    end
    it 'raises an exception if the path is not a directory' do
      expect { subject << __FILE__ }.to raise_error( Errno::ENOTDIR )
    end
  end

  describe '#[]' do
    subject { described_class.new %w| .rb | }
    before  { subject << './spec/fixtures' }

    it 'behaves normally if given an integer' do
      subject[ 0 ].should_not be_nil
      subject[ 1 ].should be_nil
    end
    it 'returns a pathname if given a string' do
      subject[ 'solar_system/body' ].should be_a( Pathname )
    end
    it 'raises an exception of the file does not exist' do
      expect { subject[ 'solar_system/pluto' ] }.to raise_error( Errno::ENOENT )
    end
    it 'raises an exception of the extension does not match' do
      expect { subject[ 'breakfast/butter' ] }.to raise_error( Errno::ENOENT )
    end
  end
end
