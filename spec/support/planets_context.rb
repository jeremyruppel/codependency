shared_context 'solar system', :files => :planets do

  before do
    file 'body.rb', <<-EOS
    class Body
    end
    EOS

    file 'earth.rb', <<-EOS
    # require planet

    class Earth
    end
    EOS

    file 'mars.rb', <<-EOS
    # require planet

    class Mars
    end
    EOS

    file 'phobos.rb', <<-EOS
    # require body
    # require mars

    class Phobos
    end
    EOS

    file 'planet.rb', <<-EOS
    # require body

    class Planet
    end
    EOS
  end
end