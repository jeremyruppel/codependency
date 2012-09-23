require 'open3'

module Codependency
  class Graph
    def initialize( start, options={} )
      @options = options
      @nodes   = Hash.new { |h, k| h[ k ] = Node.new( k, parser ) }
      @start   = @nodes[ start ]
    end

    ##
    # a topologically sorted list of all dependencies of the `start` file.
    def files
      deps = resolve( @start, [ ] ).map( &:dependencies ).join ' '

      cmd, out, err = Open3.popen3 "echo '#{deps}' | tsort"

      if msg = err.gets
        raise CircularDependencyError, msg
      end

      out.readlines.map( &:chomp ).reverse
    end

    protected

    ##
    # adds a node's dependencies to a list (memo).
    # intended to be used recursively.
    def resolve( node, list )
      list << node

      node.edges.map { |filename| @nodes[ filename ] }.each do |dep|
        resolve dep, list unless list.include?( dep )
      end

      list
    end

    ##
    # the parser to use for this graph. shared by all nodes.
    def parser
      @parser ||= Parser.new @options
    end
  end
end
