# Wikify

Active Record model versioning.

[![Build Status](https://travis-ci.org/Arcath/Wikify.png?branch=master)](https://travis-ci.org/Arcath/Wikify) | [![Code Climate](https://codeclimate.com/github/Arcath/Wikify.png)](https://codeclimate.com/github/Arcath/Wikify) | [![Coverage Status](https://coveralls.io/repos/Arcath/Wikify/badge.png)](https://coveralls.io/r/Arcath/Wikify) | [RDoc](http://rubydoc.info/github/Arcath/Wikify/master/frames)

## Installation

### Adding the Gem

Add this line to your application's Gemfile:

    gem 'wikify'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wikify
    
### Migration

Wikify has a built in generator for creating the migration which can be run using:

    $ rails g wikify:migration
    $ rake db:migrate

You will now have a table for your versions, wikify contains a model for the versions which is used by default.

## Usage

To enable wikify on your models add `wikify` to your model class:

``` ruby
class Article < ActiveRecord::Base
  wikify
end
```

Your model now has version tracking!

For an example of how Wikify works see the [Logical Function Spec](https://github.com/Arcath/Wikify/blob/master/spec/logical_function_spec.rb) which is a commented example of all the functionality (that gets tested with every push).

## Restoring a Version

Versions have a handy `restore` method that lets you very quickly and easily restore a version over the current/target model. A version stores the model & id when it gets created when you call `restore` Wikify finds the model with the stored id and then overwrites all its attributes with the ones in the versions cache.

### Restoring a deleted version

You can restore a deleted versions by using the `Wikify.destroyed_versions` method. You must supply a model and optionally an id e.g.

``` ruby
Wikify.destroyed_versions(Article)
#> An list of versions where event is "destroy" and model is "Article"
Wikify.destroyed_versions(Article, 2)
#> The destory events for the given article only
```

### Associations

#### Has-Many

Wikify can track the versions of child objects, for example a comments model attached to that articles model:

``` ruby
class Article < ActiveRecord::Base
  has_many :comments
  
  wikify
end

class Comment < ActiveRecord::Base
  belongs_to :article
  
  wikify_on_parent(:article)
end
```

This then stores versions on the parent model so that they can be tracked with it. The child model also has a `versions` method that works the same but it looks for its versions through the parent.

Again see the [Logical Function Spec](https://github.com/Arcath/Wikify/blob/master/spec/logical_function_spec.rb)  for examples of this code in action.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
