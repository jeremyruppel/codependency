require 'spec_helper'

describe Codependency::Parser do
  let( :parser ){ Codependency::Parser.new }

  before do
    IO.stub( :readlines ) do |arg|
      case File.basename( arg, '.rb' ).to_sym
      when :body
        """
        class Body
        end
        """
      when :earth
        """
        # require planet

        class Earth
        end
        """
      when :mars
        """
        # require planet

        class Mars
        end
        """
      when :phobos
        """
        # require body
        # require mars

        class Phobos
        end
        """
      when :planet
        """
        # require body

        class Planet
        end
        """
      end.strip.split( /^\s+/ )
    end
  end

  context 'body' do
    subject { parser.parse( "body.rb" ) }
    it { should eq( [ ] ) }
  end

  context 'earth' do
    subject { parser.parse( "earth.rb" ) }
    it { should eq( [ 'planet' ] ) }
  end

  context 'mars' do
    subject { parser.parse( "mars.rb" ) }
    it { should eq( [ 'planet' ] ) }
  end

  context 'phobos' do
    subject { parser.parse( "phobos.rb" ) }
    it { should eq( [ 'body', 'mars' ] ) }
  end

  context 'planet' do
    subject { parser.parse( "planet.rb" ) }
    it { should eq( [ 'body' ] ) }
  end
end
