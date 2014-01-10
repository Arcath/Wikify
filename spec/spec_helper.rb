require 'simplecov'
require 'coveralls'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start do
  add_filter "spec"
end

# Controller
require 'support/controller'

# Require Gem
require 'wikify'

ActionController::Base.load

# Require Models
require 'models/parent'
require 'models/document'
require 'models/revision'
require 'models/child'

# Configure Active Record
require 'sqlite3'
require 'support/database'
