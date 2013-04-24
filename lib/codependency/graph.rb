require 'tsort'

module Codependency
  class Graph < Hash

    ##
    # CHANGED
    def require( string )
      file = File.expand_path string

      self[ file ] ||= parser.parse( file ).map do |short|
        path[ short ].to_path
      end
      self[ file ].each { |f| self.require( f ) unless key?( f ) }
    end
    alias :<< :require

    ##
    # Returns the sorted list of files as determined by this graph,
    # relative to the calling file.
    def files
      tsort.map { |file| Pathname( file ) }
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
