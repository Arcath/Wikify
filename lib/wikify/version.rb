module Wikify
  class Version < ActiveRecord::Base
    include Wikify::VersionConcern
  end
end