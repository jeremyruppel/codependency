require 'spec_helper'

describe Codependency::Graph do
  it { should be_a( Hash ) }

  describe '#path' do
    its( :path ){ should be_a( Codependency::Path ) }
    its( :path ){ should be_empty }
  end

  describe '#require', :fixtures => true do
    before { subject.require file }

    describe 'solar_system' do
      example( 'body.rb'   ){ verify { subject } }
      example( 'earth.rb'  ){ verify { subject } }
      example( 'mars.rb'   ){ verify { subject } }
      example( 'phobos.rb' ){ verify { subject } }
      example( 'planet.rb' ){ verify { subject } }
    end
    describe 'breakfast' do
      example( 'butter.js'   ){ verify { subject } }
      example( 'egg.js'      ){ verify { subject } }
      example( 'sandwich.js' ){ verify { subject } }
      example( 'toast.js'    ){ verify { subject } }
    end
    describe 'lox' do
      example( 'money.rb'   ){ verify { subject } }
      example( 'power.rb'   ){ verify { subject } }
      example( 'respect.rb' ){ verify { subject } }
    end
    describe 'assets' do
      example( 'templates/account.js' ){ verify { subject } }
      example( 'templates/history.js' ){ verify { subject } }
      example( 'templates/user.js'    ){ verify { subject } }
      example( 'application.js'       ){ verify { subject } }
    end
  end

  describe '#tsort', :fixtures => true do
    before { subject.require file }

    describe 'solar_system' do
      example( 'body.rb'   ){ verify { subject.tsort } }
      example( 'earth.rb'  ){ verify { subject.tsort } }
      example( 'mars.rb'   ){ verify { subject.tsort } }
      example( 'phobos.rb' ){ verify { subject.tsort } }
      example( 'planet.rb' ){ verify { subject.tsort } }
    end
    describe 'breakfast' do
      example( 'butter.js'   ){ verify { subject.tsort } }
      example( 'egg.js'      ){ verify { subject.tsort } }
      example( 'sandwich.js' ){ verify { subject.tsort } }
      example( 'toast.js'    ){ verify { subject.tsort } }
    end
    describe 'lox' do
      example( 'money.rb'   ){ expect { subject.tsort }.to raise_error( TSort::Cyclic ) }
      example( 'power.rb'   ){ expect { subject.tsort }.to raise_error( TSort::Cyclic ) }
      example( 'respect.rb' ){ expect { subject.tsort }.to raise_error( TSort::Cyclic ) }
    end
    describe 'assets' do
      example( 'templates/account.js' ){ verify { subject.tsort } }
      example( 'templates/history.js' ){ verify { subject.tsort } }
      example( 'templates/user.js'    ){ verify { subject.tsort } }
      example( 'application.js'       ){ verify { subject.tsort } }
    end
  end

  describe '#files', :fixtures => true do
    before { subject.require file }

    describe 'solar_system' do
      example( 'body.rb'   ){ verify { subject.files } }
      example( 'earth.rb'  ){ verify { subject.files } }
      example( 'mars.rb'   ){ verify { subject.files } }
      example( 'phobos.rb' ){ verify { subject.files } }
      example( 'planet.rb' ){ verify { subject.files } }
    end
    describe 'breakfast' do
      example( 'butter.js'   ){ verify { subject.files } }
      example( 'egg.js'      ){ verify { subject.files } }
      example( 'sandwich.js' ){ verify { subject.files } }
      example( 'toast.js'    ){ verify { subject.files } }
    end
    describe 'lox' do
      example( 'money.rb'   ){ expect { subject.files }.to raise_error( TSort::Cyclic ) }
      example( 'power.rb'   ){ expect { subject.files }.to raise_error( TSort::Cyclic ) }
      example( 'respect.rb' ){ expect { subject.files }.to raise_error( TSort::Cyclic ) }
    end
    describe 'assets' do
      example( 'templates/account.js' ){ verify { subject.files } }
      example( 'templates/history.js' ){ verify { subject.files } }
      example( 'templates/user.js'    ){ verify { subject.files } }
      example( 'application.js'       ){ verify { subject.files } }
    end
  end

  describe '#scan', :fixtures => true do
    before { subject.scan file }

    describe 'solar_system' do
      example( '*.rb' ){ verify { subject.files } }
    end
    describe 'breakfast' do
      example( '*.js' ){ verify { subject.files } }
    end
    describe 'assets' do
      example( '*.js' ){ verify { subject.files } }
      example( 'templates/*.js' ){ verify { subject.files } }
    end
  end
end
