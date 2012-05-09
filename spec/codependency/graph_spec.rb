require 'spec_helper'

describe Codependency::Graph do
  let( :path ){ File.join( File.dirname( __FILE__ ), '../fixtures' ) }
  subject { Codependency::Graph.new Dir[ File.join( path, '*.rb' ) ] }

  pending
  # its( :files ){ should eq(
  #   [
  #     "#{path}/body.rb",
  #     "#{path}/planet.rb",
  #     "#{path}/earth.rb",
  #     "#{path}/mars.rb",
  #     "#{path}/phobos.rb"
  #   ]
  # ) }
end
