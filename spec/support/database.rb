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
  
  create_table :children do |table|
    table.column :name, :string
    table.column :parent_id, :integer
    
    table.timestamps
  end
  
  create_table :versions do |table|
    table.column :resource_id, :integer
    table.column :resource_type, :string
    table.column :data, :text
    table.column :linked_child_resource_type, :string
    table.column :linked_child_resource_id, :integer
    table.column :linked_child, :boolean, default: false
    table.column :event, :string
    table.column :comitter_id, :integer
    
    table.timestamps
  end
  
  create_table :revisions do |table|
    table.column :thing_id, :integer
    table.column :thing_type, :string
    table.column :linked_child_thing_id, :integer
    table.column :linked_child_thing_type, :string
    table.column :linked_child, :boolean, default: false
    table.column :data, :text
    table.column :event, :string
    table.column :comitter_id, :integer
    
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
    Child.all.count.should eq 0
  end
  
  it "should work" do
    parent = Parent.new
    parent.name = "Hello World"
    parent.save
    Parent.last.name.should eq "Hello World"
  end
end