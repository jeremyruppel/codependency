require 'spec_helper'

describe Codependency::Parser, :files => :planets do
  let( :parser ){ Codependency::Parser.new }

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
