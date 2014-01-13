module Wikify
  class Version < ActiveRecord::Base
    self.table_name_prefix = 'wikify_'
    include Wikify::VersionConcern
  end
end