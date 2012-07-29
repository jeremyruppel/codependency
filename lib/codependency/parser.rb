module Codependency
  class Parser

    def initialize( options={} )
      @options = options
      @comment = options.delete( :comment ) || '#'
    end

    def parse( file )
      IO.readlines( file ).take_while do |line|
        line =~ pattern
      end.map { |line| line[ pattern, 1 ] }
    end

    protected

    def pattern
      @pattern ||= /^#{@comment} require (.+)$/
    end
  end
end
