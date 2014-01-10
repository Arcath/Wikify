require 'simplecov'
SimpleCov.start do
  add_group "Source", "lib"
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
