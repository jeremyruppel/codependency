require 'spec_helper'

describe Codependency::Graph do
  context 'planets', :files => :planets do
    subject { Codependency::Graph.new graph }

    context 'earth' do
      let( :graph ){ 'earth.rb' }
      its( :files ){ should eq( %w| body.rb planet.rb earth.rb | ) }
    end

    context 'phobos' do
      let( :graph ){ 'phobos.rb' }
      its( :files ){ should eq( %w| body.rb planet.rb mars.rb phobos.rb | ) }
    end
  end

  context 'breakfasts', :files => :breakfasts do
    subject { Codependency::Graph.new graph, :comment => '//' }

    context 'sandwich' do
      let( :graph ){ 'sandwich.js' }
      its( :files ){ should eq( %w| butter.js toast.js egg.js sandwich.js | ) }
    end
  end
end
