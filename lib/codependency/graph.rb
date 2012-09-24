require 'tsort'

module Codependency
  class Graph < Hash
    def initialize( path, options={} )
      @path, @options = path, options

      super( ){ |h, k| h[ k ] = parser.parse( k ) }
    end
    attr_reader :path, :options

    include TSort

    ##
    # the dirname to use for this graph, based on the path
    def dirname
      File.dirname path
    end

    ##
    # the extname to use for this graph, based on the path
    def extname
      File.extname path
    end

    ##
    # walk the entire graph and return self
    def populate
      walk path
      self
    end

    ##
    # discover all nodes in this graph by walking it
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

    private

    # tsort interface
    alias :tsort_each_node :each_key

    # tsort interface
    def tsort_each_child( node, &block )
      fetch( node ).each( &block )
    end
  end
end
