# Version Number
require "wikify/version_number"

# Gems
require 'active_record'
require 'active_support'

# Internal Requires
require "wikify/child_methods"
require "wikify/controller"
require "wikify/methods"
require "wikify/model"
require "wikify/version_concern"
require "wikify/version"

# Wikify
#
# Model Versioning for ActiveRecord
module Wikify
  # Searches the version table for destroy events, takes an optional id when you know exactly what you are looking for.
  #
  #    Wikify.destroyed_versions(Model, 10)
  def self.destroyed_versions(model, id = nil)
    hash =  {"#{model.wikify_options[:assoc_as]}_type".to_sym => model.to_s, event: "destroy"}
    hash["#{model.wikify_options[:assoc_as]}_id".to_sym] = id if id
    model.wikify_options[:assoc_model].constantize.where(hash)
  end
  
  # Stores the current users id within the current thread (lets us get it from the controller)
  def self.set_user_id(id)
    thread_store.user_id = id
  end
  
  # Returns the stored id
  def self.user_id
    thread_store.user_id
  end
  
  private
  
  def self.thread_store
    Thread.current[:wikify_store] ||= OpenStruct.new({user_id: nil})
  end
end


ActiveSupport.on_load(:active_record) do
  include Wikify::Model
end

if defined?(ActionController)
  ActiveSupport.on_load(:action_controller) do
    include Wikify::Controller
  end
end
