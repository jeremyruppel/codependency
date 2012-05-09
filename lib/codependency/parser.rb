module Codependency
  class Parser

    def parse( file )
      IO.readlines( file ).take_while do |line|
        line =~ pattern
      end.map { |line| line[ pattern, 1 ].to_sym }
    end

    protected

    def pattern
      @pattern ||= /^# require (.+)$/
    end
  end
end
