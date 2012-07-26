require 'spec_helper'

describe Codependency::Parser, :files => :planets do
  let( :parser ){ Codependency::Parser.new }

  context 'body dependencies' do
    subject { parser.parse( "body.rb" ) }
    it { should eq( [ ] ) }
  end

  context 'earth dependencies' do
    subject { parser.parse( "earth.rb" ) }
    it { should eq( [ 'planet' ] ) }
  end

  context 'mars dependencies' do
    subject { parser.parse( "mars.rb" ) }
    it { should eq( [ 'planet' ] ) }
  end

  context 'phobos dependencies' do
    subject { parser.parse( "phobos.rb" ) }
    it { should eq( [ 'body', 'mars' ] ) }
  end

  context 'planet dependencies' do
    subject { parser.parse( "planet.rb" ) }
    it { should eq( [ 'body' ] ) }
  end
end
