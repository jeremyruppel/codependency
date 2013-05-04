require 'tsort'

module Codependency
  class Graph < Hash

    ##
    # Add the given file to this graph. Creates a new entry in the
    # graph, the key of which is the relative path to this file and
    # the value is the array of relative paths to its dependencies.
    # Any dependent files will also be recursively added to this
    # graph.
    def require( file )
      return if key?( file )

      self[ file ] = deps( file )
      self[ file ].each do |dependency|
        self.require dependency
      end
    end
    alias :<< :require

    ##
    # Parses all of the files in the given glob and adds their
    # dependencies to the graph. A file in this glob is not added
    # to the graph unless another file in the glob depends on it.
    def scan( glob )
      Dir[ glob ].flat_map { |f| deps( f ) }.uniq.each do |dependency|
        self.require dependency
      end
    end

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
    def path_to( file )
      path = Pathname( file )
              .expand_path
              .relative_path_from( root )
              .to_path

      path.start_with?( '.' ) ? path : File.join( '.', path )
    end

    ##
    # Parses the file and returns the relative paths to its dependencies.
    def deps( file )
      parser.parse( file ).map { |f| path_to path[ f ] }
    end
  end
end
