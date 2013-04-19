module Codependency
  class Parser

    PATTERNS = Hash.new { |hash, key|
      raise "Unknown extension '#{key}'. Known extensions are #{hash.keys.inspect}."
    }
    PATTERNS[ '.rb' ] = /^#= require ([\w\/]+)$/
    PATTERNS[ '.js' ] = /^\/\/= require ([\w\/]+)$/

    ##
    # Determines a file's dependencies based on the file's extension.
    def parse( file )
      pattern = PATTERNS[ File.extname( file ) ]

      IO.readlines( file ).take_while do |line|
        line =~ pattern
      end.map { |line| line[ pattern, 1 ] }
    end

    def extensions
      PATTERNS.keys
    end
  end
end
