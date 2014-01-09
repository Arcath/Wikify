require 'spec_helper'

describe Child do
  it "should have the wikify methods" do
    Child._create_callbacks.length.should eq 1
    Child._update_callbacks.length.should eq 1
    Child._destroy_callbacks.length.should eq 1
  end
  
  it "should have the callback methods" do
    child = Parent.last.children.new
    child.methods.include?(:wikify_cache).should be_true
    child.methods.include?(:wikify_update).should be_true
    child.methods.include?(:wikify_create).should be_true
    child.methods.include?(:wikify_destroy).should be_true
  end
  
  it "should write its updates to the parent" do
    parent = Parent.new({name: "Parent 100"})
    parent.save
    
    parent.versions.count.should eq 1
    
    child = parent.children.new({name: "Child 1"})
    child.save
    
    parent.versions.count.should eq 2
    parent.versions.last.event.should eq "child create"
  end
  
  it "should record updates to the parent" do
    child = Child.find_by_name("Child 1")
    
    child.parent.versions.count.should eq 2
    
    child.name = "Child 1 Updated"
    child.save
    
    child.parent.versions.count.should eq 3
  end
  
  it "Should set the restore to values" do
    child = Child.find_by_name("Child 1 Updated")
    
    child.versions.last.restore_type.should eq "Child"
    child.versions.last.restore_id.should eq child.id
  end
  
  it "should restore a version do" do
    child = Child.find_by_name("Child 1 Updated")
    child.versions.last.restore
    
    child = Child.find(child.id)
    
    child.name.should eq "Child 1"
  end
  
  it "should create an event on destroy" do
    child = Child.find_by_name("Child 1")
    parent = child.parent
    
    c = parent.versions.count
    
    child.destroy
    
    parent.versions.count.should eq c + 1
    parent.versions.last.event.should eq "child destroy"
  end
end