# Version Number
require "wikify/version_number"

# Gems
require 'active_record'

# Internal Requires
require "wikify/methods"
require "wikify/model"
require "wikify/version_concern"
require "wikify/version"

module Wikify
  def self.destroyed_versions(model, id = nil)
    hash =  {"#{model.wikify_options[:assoc_as]}_type".to_sym => model.to_s, event: "destroy"}
    hash["#{model.wikify_options[:assoc_as]}_id".to_sym] = id if id
    model.wikify_options[:assoc_model].constantize.where(hash)
  end
end

class ActiveRecord::Base
  include Wikify::Model
end
