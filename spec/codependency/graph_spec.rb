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
      its( :files ){ should eq( %w| butter.js egg.js toast.js sandwich.js | ) }
    end
  end

  context 'circular dependencies', :files => :circular do
    subject { Codependency::Graph.new graph }

    let( :graph ){ 'money.rb' }

    it 'should raise an error' do
      expect { subject.files }.to raise_error( CircularDependencyError )
    end
  end

  context 'subdirectories', :files => :subdirectories do
    subject { Codependency::Graph.new graph, :comment => '//' }

    context 'application.js' do
      let( :graph ){ 'application.js' }
      its( :files ){ should eq( %w| templates/user/history.js templates/user/account.js templates/user.js application.js | ) }
    end
  end
end
