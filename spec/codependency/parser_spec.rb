require 'spec_helper'

describe Codependency::Parser do
  let( :dirname  ){ example.example_group.description }
  let( :basename ){ example.description }
  let( :filename ){ "./spec/fixtures/#{dirname}/#{basename}" }
  let( :file     ){ Pathname( filename ) }

  # TODO convert these to approvals?
  context 'solar_system' do
    example 'body.rb' do
      subject.parse( file ).should == [ ]
    end
    example 'earth.rb' do
      subject.parse( file ).should == [
        'solar_system/planet'
      ]
    end
    example 'mars.rb' do
      subject.parse( file ).should == [
        'solar_system/planet'
      ]
    end
    example 'phobos.rb' do
      subject.parse( file ).should == [
        'solar_system/body',
        'solar_system/mars'
      ]
    end
    example 'planet.rb' do
      subject.parse( file ).should == [
        'solar_system/body'
      ]
    end
  end
  context 'breakfast' do
    example 'butter.js' do
      subject.parse( file ).should == [ ]
    end
    example 'egg.js' do
      subject.parse( file ).should == [
        'breakfast/butter'
      ]
    end
    example 'toast.js' do
      subject.parse( file ).should == [
        'breakfast/butter'
      ]
    end
    example 'sandwich.js' do
      subject.parse( file ).should == [
        'breakfast/egg',
        'breakfast/toast'
      ]
    end
  end
end
