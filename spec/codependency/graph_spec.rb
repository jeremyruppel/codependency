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

  end

  # describe 'old shit', :broken => true do
  #
  #   describe 'accessors' do
  #     subject { described_class.new 'planets/phobos.rb' }
  #     its( :path    ){ should eq( 'planets/phobos.rb' ) }
  #     its( :dirname ){ should eq( 'planets' ) }
  #     its( :extname ){ should eq( '.rb' ) }
  #     its( :options ){ should eq( { } ) }
  #   end
  #
  #   describe 'populate', :files => :planets do
  #     subject { described_class.new './phobos.rb' }
  #
  #     context 'initially' do
  #       it { should be_empty }
  #     end
  #
  #     context 'after calling populate' do
  #       before { subject.populate }
  #
  #       it { should include( './phobos.rb' => [ './body.rb', './mars.rb' ] ) }
  #       it { should include( './mars.rb'   => [ './planet.rb' ] ) }
  #       it { should include( './planet.rb' => [ './body.rb' ] ) }
  #       it { should include( './body.rb'   => [ ] ) }
  #     end
  #
  #     it 'should return itself' do
  #       subject.populate.should == subject
  #     end
  #   end
  #
  #   context 'planets', :files => :planets do
  #     subject { described_class.new start }
  #
  #     context 'earth' do
  #       let( :start ){ './earth.rb' }
  #       its( :files ){ should eq( %w| ./body.rb ./planet.rb ./earth.rb | ) }
  #     end
  #
  #     context 'phobos' do
  #       let( :start ){ './phobos.rb' }
  #       its( :files ){ should eq( %w| ./body.rb ./planet.rb ./mars.rb ./phobos.rb | ) }
  #     end
  #   end
  #
  #   context 'breakfasts', :files => :breakfasts do
  #     subject { described_class.new start, :comment => '//' }
  #
  #     context 'sandwich' do
  #       let( :start ){ './sandwich.js' }
  #       its( :files ){ should eq( %w| ./butter.js ./egg.js ./toast.js ./sandwich.js | ) }
  #     end
  #   end
  #
  #   context 'circular dependencies', :files => :circular do
  #     subject { described_class.new start }
  #
  #     let( :start ){ './money.rb' }
  #
  #     it 'should raise an error' do
  #       expect { subject.files }.to raise_error( TSort::Cyclic )
  #     end
  #   end
  #
  #   context 'subdirectories', :files => :subdirectories do
  #     subject { described_class.new start, :comment => '//' }
  #
  #     context 'application.js' do
  #       let( :start ){ 'assets/application.js' }
  #       its( :files ){ should eq( %w| assets/templates/user/history.js assets/templates/user/account.js assets/templates/user.js assets/application.js | ) }
  #     end
  #   end
  # end
end
