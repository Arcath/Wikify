class Child < ActiveRecord::Base
  belongs_to :parent
  
  wikify_on_parent(:parent)
end