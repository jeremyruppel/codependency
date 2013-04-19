require 'spec_helper'

describe Codependency::Path do
  it { should be_an( Array ) }

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
    before { subject << './spec/fixtures' }

    it 'behaves normally if given an integer' do
      subject[ 0 ].should_not be_nil
      subject[ 1 ].should be_nil
    end
    it 'returns a pathname if given a string' do
      subject[ 'solar_system/body.rb' ].should be_a( Pathname )
    end
    it 'raises an exception of the file does not exist' do
      expect { subject[ 'solar_system/pluto.rb' ] }.to raise_error( Errno::ENOENT )
    end
  end
end
