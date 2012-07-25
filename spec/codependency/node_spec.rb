require 'spec_helper'

describe Codependency::Node do
  context 'when the file exists', :files => :planets do
    subject { Codependency::Node.new 'planet.rb' }

    its( :dependencies ){ should eq( [ 'body.rb' ] ) }
  end

  context 'when the file does not exist' do
    it 'should raise an error' do
      expect {
        Codependency::Node.new 'pluto.rb'
      }.to raise_error( Errno::ENOENT, 'No such file or directory - pluto.rb' )
    end
  end
end
