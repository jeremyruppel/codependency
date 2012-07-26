module Codependency
  class Graph
    def initialize( start )
      @nodes = Hash.new { |h, k| h[ k ] = Node.new( k, parser ) }
      @start = @nodes[ start ]
    end

    def files
      [ ].tap { |list| resolve @start, list }.reverse.map &:filename
    end

    protected

    def resolve( node, list )
      list << node # TODO if the node were in the list here,
                   # would that indicate a circular dependency?
      node.dependencies.map { |filename| @nodes[ filename ] }.each do |dep|
        if list.include?( dep )
          list << list.slice!( list.index( dep ) )
        else
          resolve dep, list
        end
      end
    end

    def parser
      @parser ||= Parser.new
    end
  end
end
