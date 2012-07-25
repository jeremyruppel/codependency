shared_context 'solar system', :files => :planets do
  def file( filename, contents )
    File.stub( :exist?  ).with( filename ){ true }
    IO.stub( :readlines ).with( filename ){ contents.strip.split( /^\s+/ ) }
  end

  before do
    file 'body.rb', <<-end
    class Body
    end

    file 'earth.rb', <<-end
    # require planet

    class Earth
    end

    file 'mars.rb', <<-end
    # require planet

    class Mars
    end

    file 'phobos.rb', <<-end
    # require body
    # require mars

    class Phobos
    end

    file 'planet.rb', <<-end
    # require body

    class Planet
    end
  end

end