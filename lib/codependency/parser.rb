module Codependency
  class Parser

    def initialize( options={} )
      @options = options
      @comment = options.delete( :comment ) || '#'
    end

    ##
    # determines a file's dependencies based on the configured comment pattern.
    def parse( file )
      IO.readlines( file ).take_while do |line|
        line =~ pattern
      end.map { |line| line[ pattern, 1 ] }
    end

    protected

    ##
    # the comment pattern to use.
    # TODO allow this to be more configurable
    def pattern
      @pattern ||= /^#{@comment} require (.+)$/
    end
  end
end
