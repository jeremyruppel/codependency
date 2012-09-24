require 'tsort'

module Codependency
  class Graph < Hash
    def initialize( path, options={} )
      @path, @options = path, options

      super( ){ |h, k| h[ k ] = parser.parse( k ) }
    end
    attr_reader :path, :options

    include TSort

    def dirname
      File.dirname path
    end

    def extname
      File.extname path
    end

    def populate
      walk path
      self
    end

    def walk( path )
      self[ path ].each { |path| walk( path ) unless has_key?( path ) }
    end

    ##
    # the parser to use for this graph. shared by all nodes.
    def parser
      @parser ||= begin
        Parser.new options.merge( :dirname => dirname, :extname => extname )
      end
    end

    ##
    # a topologically sorted list of all dependencies of the `start` file.
    def files
      populate.tsort
    end

    protected

    alias :tsort_each_node :each_key

    def tsort_each_child( node, &block )
      fetch( node ).each( &block )
    end
  end
end
