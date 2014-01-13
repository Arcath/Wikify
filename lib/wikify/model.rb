module Wikify
  module Model
    def self.included(base)
      base.extend ClassMethods
    end
    
    # Caches the model
    #
    # Called using the `after_find` callback in ActiveRecord
    def wikify_cache
      @wikify_override = {}
      @wikify_cached_object = self.attributes
    end
    
    # Allows you override the wikify options for this event
    def wikify_override(options)
      @wikify_override = options
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
        options[:no_include] ||= false
        
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
                
        include Wikify::Methods unless options[:no_include]
      end
      
      # Takes the same options as wikify
      def wikify_on_parent(parent, options = {})
        wikify(options.merge({no_include: true}))
        
        class_attribute :wikify_parent
        self.wikify_parent = parent
        
        include Wikify::ChildMethods
      end
    end
  end
end
