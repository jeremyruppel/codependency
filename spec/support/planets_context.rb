shared_context 'solar system', :files => :planets do
  before do
    IO.stub( :readlines ) do |arg|
      case File.basename( arg, '.rb' ).to_sym
      when :body
        """
        class Body
        end
        """
      when :earth
        """
        # require planet

        class Earth
        end
        """
      when :mars
        """
        # require planet

        class Mars
        end
        """
      when :phobos
        """
        # require body
        # require mars

        class Phobos
        end
        """
      when :planet
        """
        # require body

        class Planet
        end
        """
      end.strip.split( /^\s+/ )
    end
  end

end