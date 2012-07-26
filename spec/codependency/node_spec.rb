require 'spec_helper'

describe Codependency::Node do
  let( :parser ){ double 'Parser', :parse => [ 'body' ] }

  context 'when the file exists', :files => :planets do
    subject { Codependency::Node.new 'planet.rb', parser }
    its( :dependencies ){ should eq( [ 'body.rb' ] ) }
  end

  context 'when the file does not exist' do
    it 'should raise an error' do
      expect {
        Codependency::Node.new 'pluto.rb', parser
      }.to raise_error( Errno::ENOENT, 'No such file or directory - pluto.rb' )
    end
  end
end
