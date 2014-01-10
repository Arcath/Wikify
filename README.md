# Wikify

Active Record model versioning.

[![Build Status](https://travis-ci.org/Arcath/Wikify.png?branch=master)](https://travis-ci.org/Arcath/Wikify) | [![Code Climate](https://codeclimate.com/github/Arcath/Wikify.png)](https://codeclimate.com/github/Arcath/Wikify) | [![Coverage Status](https://coveralls.io/repos/Arcath/Wikify/badge.png)](https://coveralls.io/r/Arcath/Wikify)

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
