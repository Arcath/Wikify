class Parent < ActiveRecord::Base
  wikify
  
  has_many :children
end