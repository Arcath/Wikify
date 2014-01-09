module Wikify
  module VersionConcern
    extend ActiveSupport::Concern
    
    included do
      serialize :data, Hash
    end
    
    def restore
      unless event == "destroy"
        target = restore_to
        target.attributes = self.data
        target.wikify_override({event: "restore"})
        target.save
      else
        target = resource_type.constantize.new
        target.attributes = self.data
        target.wikify_override({event: "restore"})
        target.save
      end
    end
    
    def restore_to
      restore_type.constantize.find(restore_id)
    end
    
    def restore_type
      return self.send(self.attributes.keys.select {|i| i =~ /_type/ }.first.to_sym) unless self.linked_child == true
      return self.send(self.attributes.keys.select {|i| i =~ /linked_child_.*?_type/ }.first.to_sym)
    end
    
    def restore_id
      return self.send(self.attributes.keys.select {|i| i =~ /_id/ }.first.to_sym) unless self.linked_child == true
      return self.send(self.attributes.keys.select {|i| i =~ /linked_child_.*?_id/ }.first.to_sym)
    end
  end
end
