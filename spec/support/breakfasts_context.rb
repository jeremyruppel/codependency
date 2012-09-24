shared_context 'breakfast foods', :files => :breakfasts do

  before do
    file './butter.js', <<-EOS
    var Butter = { }
    EOS

    file './egg.js', <<-EOS
    // require butter
    var Egg = { }
    EOS

    file './toast.js', <<-EOS
    // require butter
    var Toast = { }
    EOS

    file './sandwich.js', <<-EOS
    // require egg
    // require toast
    var Sandwich = { }
    EOS
  end
end
