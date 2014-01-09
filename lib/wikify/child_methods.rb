module Wikify
  module ChildMethods
    def wikify_cache
      @wikify_override = {}
      @wikify_cached_object = self.attributes
    end
    
    def wikify_override(options)
      @wikify_override = options
    end
    
    def wikify_update
      new_version = new_version_instance
      new_version.data = @wikify_cached_object
      new_version.event = "child" + (@wikify_override[:event] || "update")
      new_version.save
    end
    
    def wikify_create
      new_version = new_version_instance
      new_version.event = "child create"
      new_version.save
      @wikify_cached_object = self.attributes
    end
    
    def wikify_destroy
      new_version = new_version_instance
      new_version.data = @wikify_cached_object
      new_version.event = "child destroy"
      new_version.save
    end
    
    private
    
    def new_version_instance
      self.send(wikify_parent).send(wikify_options[:assoc_name]).new({linked_child: true, linked_child_resource_type: self.class.to_s, linked_child_resource_id: self.id})
    end
    
    def wikify_search_hash
      {"linked_child_#{wikify_options[:assoc_as]}_id".to_sym => self.id, "linked_child_#{wikify_options[:assoc_as]}_type".to_sym => self.class.to_s, "linked_child" => true}
    end
  end
end