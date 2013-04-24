require 'tsort'

module Codependency
  class Graph < Hash

    ##
    # Add the given file to this graph. Creates a new entry in the
    # graph, the key of which is the expanded path to this file and
    # the value is the array of expanded paths to its dependencies.
    # Any dependent files will also be recursively added to this
    # graph.
    def require( string )
      root = Pathname.getwd
      file = Pathname( string ).expand_path.relative_path_from( root ).to_path

      self[ file ] ||= parser.parse( file ).map do |short|
        path[ short ].relative_path_from( root ).to_path
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
  end
end
