module Codependency
  class Node
    def initialize( filename, parser )
      raise Errno::ENOENT, filename unless File.exist?( filename )
      @filename = filename
      @parser   = parser
    end
    attr_reader :filename, :parser

    ##
    # all of this node's edges
    def edges
      @edges ||= begin
        parser.parse( filename ).map do |f|
          "#{f}#{File.extname( filename )}"
        end
      end
    end

    ##
    # a string representing this node's edges, formatted for `tsort`.
    def dependencies
      edges.map { |edge| [ filename, edge ] }.flatten.join ' '
    end
  end
end
