module Codependency
  class Graph
    def initialize( filenames )
      @nodes = Hash[ filenames.map { |f| [ f, Node.new( f ) ] } ]
    end
    attr_reader :nodes

    def files
      nodes.reduce( [ ] ) do |list, (filename, node)|
        resolve node, list
        list
      end
    end

    protected

    def resolve( node, list )
      unless list.include? node.filename
        node.dependencies.each do |dep|
          # TODO need to check here to make sure
          # we actually have a node for this dependency
          resolve nodes[ dep ], list
        end
        list << node.filename
      end
    end
  end
end
