require 'pathname'

module Codependency
  class Path < Array

    ##
    # Appends a path to this path set. If the path exists, it
    # will be expanded. Raises Errno::ENOENT if the path
    # does not exist. Raises Errno::ENOTDIR if the path
    # is not a directory.
    def <<( str )
      path = Pathname( str )

      case
      when !path.exist?
        raise Errno::ENOENT, path.to_path
      when !path.directory?
        raise Errno::ENOTDIR, path.to_path
      else
        super path.expand_path
      end
    end

    ##
    # Sugar syntax for calling #find if given a string.
    # Otherwise, behaves like normal array access.
    def []( path_or_index )
      if path_or_index.is_a? String
        find path_or_index
      else
        super
      end
    end

    ##
    # Attempts to find the given file in this path set.
    # Raises Errno::ENOENT if the file cannot be found.
    def find( str )
      super lambda { raise Errno::ENOENT, str } do |dir|
        path = dir.join str
        return path if path.exist?
      end
    end
  end
end
