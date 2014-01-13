module Wikify
  module VersionConcern
    extend ActiveSupport::Concern
    
    included do
      serialize :data, Hash
      
      before_save :record_comitter
    end
    
    # Finds the model/instance to restore to and then over writes all its data.
    #
    # Also over rides the version event to restore so you can tell the difference between a restore and an update in your history.
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
    
    # Finds the model to restore type
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
    
    # Gets the comitter from the Wikify thread store
    def record_comitter
      self.comitter_id = Wikify.user_id if Wikify.user_id != nil
    end
  end
end
