module Wikify
  # Methods that get included on models using wikify
  module Methods
    # The Wikify update operation
    #
    # Creates a new version, records the cached object and saves it as an update
    def wikify_update
      new_version = self.send(wikify_options[:assoc_name]).new
      new_version.data = @wikify_cached_object
      new_version.event = (@wikify_override[:event] || "update")
      new_version.save
    end
    
    # The Wikify create operation
    #
    # Creates a new version with no data and sets the event to create
    def wikify_create
      new_version = self.send(wikify_options[:assoc_name]).new
      new_version.event = "create"
      new_version.save
      @wikify_cached_object = self.attributes
    end
    
    # The Wikify destroy operation
    #
    # Creates a new version recods the cached object and saves it as a destroy
    def wikify_destroy
      new_version = self.send(wikify_options[:assoc_name]).new
      new_version.data = @wikify_cached_object
      new_version.event = "destroy"
      new_version.save
    end
    
    # The hash used to find versions
    def wikify_search_hash
      {"#{wikify_options[:assoc_as]}_id".to_sym => self.id, "#{wikify_options[:assoc_as]}_type".to_sym => self.class.to_s}
    end
  end
end