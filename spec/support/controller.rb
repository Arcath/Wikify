module ActionController
  API = true
  
  class Base
    def self.load
      ActiveSupport.run_load_hooks(:action_controller, self)
    end
    
    def self.before_filter(sym)
      true
    end
  end
end

class Controller < ActionController::Base
  def initialize
    set_wikify_user
  end
  
  def current_user
    OpenStruct.new({id: 1})
  end
  
  def request
    parent = Parent.find_by_name("Committer 1")
    parent.name = "Committer 1 Updated"
    parent.save
  end
end

class NilController < ActionController::Base
  def initialize
    set_wikify_user
  end
  
  def current_user
    nil
  end
  
  def request
    parent = Parent.find_by_name("Committer 1")
    parent.name = "Committer 1 Updated"
    parent.save
  end
end