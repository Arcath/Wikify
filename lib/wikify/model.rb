module Wikify
  module Model
    def self.included(base)
      base.extend ClassMethods
    end
    
    module ClassMethods
      # Enables the wikify functionality on the model
      #
      # Takes a hash of options:
      #
      # :assoc_name => :versions
      # :assoc_as => :resource
      # :assoc_model => "Wikify::Version"
      #
      def wikify(options = {})
        # Create a class_attribute to store the wikify options hash in
        class_attribute :wikify_options
        
        # Set some Defaults
        options[:assoc_name] ||=  :versions
        options[:assoc_as] ||= :resource
        options[:assoc_model] ||= "Wikify::Version"
        
        # Store the Options Hash
        self.wikify_options = options.dup
        
        # Register the Callbacks
        after_find :wikify_cache
        after_create :wikify_create
        after_update :wikify_update
        after_destroy :wikify_destroy

        # Allow reading of the cached object
        attr_reader :wikify_cached_object
        
        # Define a method to access the versions
        define_method(wikify_options[:assoc_name]){
          wikify_options[:assoc_model].constantize.where(wikify_search_hash)
        }
        
        include Wikify::Methods
      end
    end
  end
end
