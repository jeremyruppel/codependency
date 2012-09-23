shared_context 'subdirectories', :files => :subdirectories do

  before do
    file 'application.js', <<-EOS
    // require templates/user
    EOS

    file 'templates/user.js', <<-EOS
    // require templates/user/history
    // require templates/user/account
    EOS

    file 'templates/user/history.js', <<-EOS
    var History = { }
    EOS

    file 'templates/user/account.js', <<-EOS
    var Account = { }
    EOS
  end
end
