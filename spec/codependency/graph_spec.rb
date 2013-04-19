require 'spec_helper'

describe Codependency::Graph do
  it { should be_a( Hash ) }

  describe '#path' do
    its( :path ){ should be_a( Codependency::Path ) }
    its( :path ){ should be_empty }
  end

  describe '#require' do
    let( :dirname  ){ example.example_group.description }
    let( :basename ){ example.description }
    let( :file     ){ File.join dirname, basename }

    before { subject.path << './spec/fixtures' }
    before { subject << file }

    describe 'solar_system' do
      example( 'body'   ){ verify { subject } }
      example( 'earth'  ){ verify { subject } }
      example( 'mars'   ){ verify { subject } }
      example( 'phobos' ){ verify { subject } }
      example( 'planet' ){ verify { subject } }
    end
    describe 'breakfast' do
      example( 'butter'   ){ verify { subject } }
      example( 'egg'      ){ verify { subject } }
      example( 'sandwich' ){ verify { subject } }
      example( 'toast'    ){ verify { subject } }
    end
    describe 'lox' do
      example( 'money'   ){ verify { subject } }
      example( 'power'   ){ verify { subject } }
      example( 'respect' ){ verify { subject } }
    end
    describe 'assets' do
      example( 'templates/account' ){ verify { subject } }
      example( 'templates/history' ){ verify { subject } }
      example( 'templates/user'    ){ verify { subject } }
      example( 'application'       ){ verify { subject } }
    end
  end

  describe '#files' do
    let( :dirname  ){ example.example_group.description }
    let( :basename ){ example.description }
    let( :file     ){ File.join dirname, basename }

    before { subject.path << './spec/fixtures' }
    before { subject << file }

    describe 'solar_system' do
      example( 'body'   ){ verify { subject.files } }
      example( 'earth'  ){ verify { subject.files } }
      example( 'mars'   ){ verify { subject.files } }
      example( 'phobos' ){ verify { subject.files } }
      example( 'planet' ){ verify { subject.files } }
    end
    describe 'breakfast' do
      example( 'butter'   ){ verify { subject.files } }
      example( 'egg'      ){ verify { subject.files } }
      example( 'sandwich' ){ verify { subject.files } }
      example( 'toast'    ){ verify { subject.files } }
    end
    describe 'lox' do
      example( 'money'   ){ expect { subject.files }.to raise_error( TSort::Cyclic ) }
      example( 'power'   ){ expect { subject.files }.to raise_error( TSort::Cyclic ) }
      example( 'respect' ){ expect { subject.files }.to raise_error( TSort::Cyclic ) }
    end
    describe 'assets' do
      example( 'templates/account' ){ verify { subject.files } }
      example( 'templates/history' ){ verify { subject.files } }
      example( 'templates/user'    ){ verify { subject.files } }
      example( 'application'       ){ verify { subject.files } }
    end
  end
end
