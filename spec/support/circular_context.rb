shared_context 'circular dependencies', :files => :circular do

  before do
    file './money.rb', <<-EOS
    # require power

    class Money
    end
    EOS

    file './power.rb', <<-EOS
    # require respect

    class Power
    end
    EOS

    file './respect.rb', <<-EOS
    # require money

    class Respect
    end
    EOS
  end
end
