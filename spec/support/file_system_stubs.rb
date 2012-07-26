module FileSystemStubs

  ##
  # stubs the filesystem methods that codependency
  # uses to retrieve file contents
  def file( filename, contents )
    File.stub( :exist?  ).with( filename ){ true }
    IO.stub( :readlines ).with( filename ){ contents.strip.split( /^\s+/ ) }
  end
end
