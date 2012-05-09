require 'spec_helper'

describe Codependency::Parser do
  let( :path   ){ File.join( File.dirname( __FILE__ ), '../fixtures' ) }
  let( :parser ){ Codependency::Parser.new }

  context 'body' do
    subject { parser.parse( "#{path}/body.rb" ) }
    it { should eq( [ ] ) }
  end

  context 'earth' do
    subject { parser.parse( "#{path}/earth.rb" ) }
    it { should eq( [ :planet ] ) }
  end

  context 'mars' do
    subject { parser.parse( "#{path}/mars.rb" ) }
    it { should eq( [ :planet ] ) }
  end

  context 'phobos' do
    subject { parser.parse( "#{path}/phobos.rb" ) }
    it { should eq( [ :body, :mars ] ) }
  end

  context 'planet' do
    subject { parser.parse( "#{path}/planet.rb" ) }
    it { should eq( [ :body ] ) }
  end
end
