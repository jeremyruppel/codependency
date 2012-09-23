require 'pathname'

module Codependency
  class Node
    def initialize( filename, parser )
      raise Errno::ENOENT, filename unless File.exist?( filename )
      @filename = filename
      @parser   = parser
    end
    attr_reader :filename, :parser

    def edges
      @edges ||= begin
        parser.parse( filename ).map do |f|
          dirname.join( "#{f}#{extname}" ).to_s
        end
      end
    end

    def dependencies
      edges.map { |edge| [ filename, edge ] }.flatten.join ' '
    end

    protected

    def dirname
      path.dirname
    end

    def extname
      path.extname
    end

    def path
      @path ||= Pathname.new filename
    end
  end
end
