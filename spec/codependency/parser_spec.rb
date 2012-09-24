require 'spec_helper'

describe Codependency::Parser do
  context 'planets', :files => :planets do
    let( :parser ){ Codependency::Parser.new }

    context 'body' do
      subject { parser.parse( './body.rb' ) }
      it { should eq( [ ] ) }
    end
    context 'earth' do
      subject { parser.parse( './earth.rb' ) }
      it { should eq( [ './planet.rb' ] ) }
    end
    context 'mars' do
      subject { parser.parse( './mars.rb' ) }
      it { should eq( [ './planet.rb' ] ) }
    end
    context 'phobos' do
      subject { parser.parse( './phobos.rb' ) }
      it { should eq( [ './body.rb', './mars.rb' ] ) }
    end
    context 'planet' do
      subject { parser.parse( './planet.rb' ) }
      it { should eq( [ './body.rb' ] ) }
    end
  end

  context 'breakfasts', :files => :breakfasts do
    let( :parser ){ Codependency::Parser.new :comment => '//', :extname => '.js' }

    context 'butter' do
      subject { parser.parse( './butter.js' ) }
      it { should eq( [ ] ) }
    end
    context 'egg' do
      subject { parser.parse( './egg.js' ) }
      it { should eq( [ './butter.js' ] ) }
    end
    context 'toast' do
      subject { parser.parse( './toast.js' ) }
      it { should eq( [ './butter.js' ] ) }
    end
    context 'sandwich' do
      subject { parser.parse( './sandwich.js' ) }
      it { should eq( [ './egg.js', './toast.js' ] ) }
    end
  end
end
