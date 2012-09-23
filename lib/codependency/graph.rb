require 'open3'

module Codependency
  class Graph
    def initialize( start, options={} )
      @options = options
      @nodes   = Hash.new { |h, k| h[ k ] = Node.new( k, parser ) }
      @start   = @nodes[ start ]
    end

    def files
      deps = resolve( @start, [ ] ).map( &:dependencies ).join ' '

      cmd, out, err = Open3.popen3 "echo '#{deps}' | tsort"

      if msg = err.gets
        raise CircularDependencyError, msg
      end

      out.readlines.map( &:chomp ).reverse
    end

    protected

    def resolve( node, list )
      list << node

      node.edges.map { |filename| @nodes[ filename ] }.each do |dep|
        if list.include?( dep )
          list << list.slice!( list.index( dep ) )
        else
          resolve dep, list
        end
      end

      list
    end

    def parser
      @parser ||= Parser.new @options
    end
  end
end
