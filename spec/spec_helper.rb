require 'simplecov'
SimpleCov.start do
  add_group "Source", "lib"
  add_group "Specs", "spec"
end

# Require Gem
require 'wikify'

# Require Models
require 'models/parent'
require 'models/document'
require 'models/revision'

# Configure Active Record
require 'sqlite3'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => ':memory:'
)

puts "Database Creation"
puts "---------------"

ActiveRecord::Schema.define do
  create_table :parents do |table|
    table.column :name, :string
    
    table.timestamps
  end
  
  create_table :versions do |table|
    table.column :resource_id, :integer
    table.column :resource_type, :string
    table.column :data, :text
    table.column :event, :string
    
    table.timestamps
  end
  
  create_table :revisions do |table|
    table.column :thing_id, :integer
    table.column :thing_type, :string
    table.column :data, :text
    table.column :event, :string
    
    table.timestamps
  end
  
  create_table :documents do |table|
    table.column :title, :string
    
    table.timestamps
  end
end

puts "---------------"
puts "Begin Tests"
puts "---------------"

describe "The Database" do
  it "should be empty" do
    Parent.all.count.should eq 0
  end
  
  it "should work" do
    parent = Parent.new
    parent.name = "Hello World"
    parent.save
    Parent.last.name.should eq "Hello World"
  end
end
