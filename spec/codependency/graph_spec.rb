require 'spec_helper'

describe Codependency::Graph, :files => :planets do
  subject { Codependency::Graph.new 'phobos.rb' }

  its( :files ){ should eq(
    [
      'body.rb',
      'planet.rb',
      'mars.rb',
      'phobos.rb'
    ]
  ) }
end
