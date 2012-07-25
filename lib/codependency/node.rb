require 'pathname'

module Codependency
  class Node
    def initialize( filename )
      raise Errno::ENOENT, filename unless File.exist?( filename )
      @filename = filename
    end
    attr_reader :filename

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

    def parser
      @parser ||= Parser.new
    end
  end
end
