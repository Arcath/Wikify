module Wikify
  module Methods
    def wikify_cache
      @wikify_override = {}
      @wikify_cached_object = self.attributes
    end
    
    def wikify_override(options)
      @wikify_override = options
    end
    
    def wikify_update
      new_version = self.send(wikify_options[:assoc_name]).new
      new_version.data = @wikify_cached_object
      new_version.event = (@wikify_override[:event] || "update")
      new_version.save
    end
    
    def wikify_create
      new_version = self.send(wikify_options[:assoc_name]).new
      new_version.event = "create"
      new_version.save
      @wikify_cached_object = self.attributes
    end
    
    def wikify_destroy
      new_version = self.send(wikify_options[:assoc_name]).new
      new_version.data = @wikify_cached_object
      new_version.event = "destroy"
      new_version.save
    end
    
    def wikify_search_hash
      {"#{wikify_options[:assoc_as]}_id".to_sym => self.id, "#{wikify_options[:assoc_as]}_type".to_sym => self.class.to_s}
    end
  end
end