# Wikify

Active Record model versioning.

## Installation

Add this line to your application's Gemfile:

    gem 'wikify'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wikify

## Usage

To enable wikify on your models add `wikify` to your model class e.g.

``` ruby
class Foo < ActiveRecord::Base
  wikify
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
