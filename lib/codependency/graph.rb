require 'tsort'

module Codependency
  class Graph < Hash

    ##
    # Add the given file to this graph. Creates a new entry in the
    # graph, the key of which is the relative path to this file and
    # the value is the array of relative paths to its dependencies.
    # Any dependent files will also be recursively added to this
    # graph.
    def require( string )
      file = path_to string

      self[ file ] ||= parser.parse( file ).map do |short|
        path_to path[ short ]
      end
      self[ file ].each { |f| self.require( f ) unless key?( f ) }
    end
    alias :<< :require

    ##
    # Returns the sorted list of files as determined by this graph,
    # relative to the calling file.
    def files
      tsort
    end

    ##
    # The path set for this dependency graph.
    def path
      @path ||= Path.new parser.extensions
    end

    ##
    # The file parser for this dependency graph.
    def parser
      @parser ||= Parser.new
    end

    private

    include TSort

    ##
    # tsort interface
    alias :tsort_each_node :each_key

    ##
    # tsort interface
    def tsort_each_child( node, &block )
      fetch( node ).each( &block )
    end

    ##
    # The current working directory of this graph. All paths in the graph
    # will be relative to this path.
    def root
      @root ||= Pathname.getwd
    end

    ##
    # Returns the given path, relative to the `#root` path.
    def path_to( string )
      path = Pathname( string )
              .expand_path
              .relative_path_from( root )
              .to_path

      path.start_with?( '.' ) ? path : File.join( '.', path )
    end
  end
end
