class Revision < ActiveRecord::Base
  include Wikify::VersionConcern
end