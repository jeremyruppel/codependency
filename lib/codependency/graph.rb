require 'tsort'

module Codependency
  class Graph < Hash

    ##
    # Adds a file to the dependency graph. The filename given should be
    # relative and should not contain an extension, like:
    #
    # # require application/user
    #
    # Attempts to locate and add all dependencies of this file recursively,
    # creating our graph.
    def require( file )
      self[ file ] ||= parser.parse path[ file ]
      self[ file ].each do |file|
        self << file unless key?( file )
      end
    end
    alias :<< :require

    ##
    # Returns the sorted list of files as determined by this graph,
    # relative to the calling file.
    def files
      here = Pathname( caller.first.split( ':' ).shift )
      tsort.map { |file| path[ file ].relative_path_from( here ) }
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
