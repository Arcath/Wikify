module Wikify
  module Controller
    def self.included(base)
      if defined?(ActionController) && (base == ActionController::Base || base == ActionController::API)
        base.before_filter :set_wikify_user
      end
    end
    
    def current_user_wikify
      current_user if defined?(current_user)
    end
    
    def set_wikify_user
      Wikify.set_user_id(current_user_wikify.id)
    end
  end
end