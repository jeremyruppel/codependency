# Codependency

Codependency is a simple comment-based dependency graph that you can use on arbitrary files.

## Installation

Add this line to your application's Gemfile:

    gem 'codependency'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install codependency

## Usage

Say you have two files, `bar.rb` and `foo.rb`. `bar` comes before `foo` in a
natural naming scheme, but `bar` has a dependency on `foo`. We can express
this using a simple comment syntax at the head of the file like this:

**bar.rb:**

``` rb
#= require foo

class Bar
end
```

**foo.rb:**

``` rb
class Foo
end
```

Then, we create a dependency graph to determine the order in which the files might need to be loaded, inserted, or compiled:

``` rb
graph = Codependency::Graph.new
graph.path << '.' # works like PATH, append search paths for this graph
graph.files # => ["./foo.rb", "./bar.rb"] # returns a topologically sorted list of relative filepaths
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
