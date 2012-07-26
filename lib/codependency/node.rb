require 'pathname'

module Codependency
  class Node
    def initialize( filename, parser )
      raise Errno::ENOENT, filename unless File.exist?( filename )
      @filename = filename
      @parser   = parser
    end
    attr_reader :filename, :parser

    def dependencies
      parser.parse( filename ).map { |f| dirname.join( "#{f}#{extname}" ).to_s }
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
