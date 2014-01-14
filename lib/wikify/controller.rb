module Wikify
  
  # Used to extend ActionController with the required methods
  module Controller
    
    # Adds the before filter trigger to ActionController (aka your ApplicationController)
    def self.included(base)
      if defined?(ActionController) && (base == ActionController::Base || base == ActionController::API)
        base.before_filter :set_wikify_user
      end
    end
    
    # Default method for finding the current user
    def current_user_wikify
      current_user if defined?(current_user)
    end
    
    # The before filter method that stores the user id in Wikify
    def set_wikify_user
      Wikify.set_user_id(current_user_wikify.id) if current_user_wikify != nil
    end
  end
end