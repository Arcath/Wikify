require 'simplecov'
SimpleCov.start do
  add_group "Source", "lib"
  add_filter "spec"
end

# Require Gem
require 'wikify'

# Require Models
require 'models/parent'
require 'models/document'
require 'models/revision'

# Configure Active Record
require 'sqlite3'
require 'support/database'
