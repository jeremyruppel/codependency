shared_context 'subdirectories', :files => :subdirectories do

  before do
    file 'assets/application.js', <<-EOS
    // require templates/user
    EOS

    file 'assets/templates/user.js', <<-EOS
    // require templates/user/history
    // require templates/user/account
    EOS

    file 'assets/templates/user/history.js', <<-EOS
    var History = { }
    EOS

    file 'assets/templates/user/account.js', <<-EOS
    var Account = { }
    EOS
  end
end
