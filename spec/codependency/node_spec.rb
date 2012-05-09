require 'spec_helper'

describe Codependency::Node do
  let( :path ){ File.join( File.dirname( __FILE__ ), '../fixtures' ) }

  context 'when the file exists' do
    subject { Codependency::Node.new "#{path}/planet.rb" }

    its( :dependencies ){ should eq( [ "#{path}/body.rb" ] ) }
  end

  context 'when the file does not exist' do
    it 'should raise an error' do
      expect {
        Codependency::Node.new "#{path}/pluto.rb"
      }.to raise_error( Errno::ENOENT )
    end
  end
end
