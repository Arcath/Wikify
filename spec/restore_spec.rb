require 'spec_helper'

describe "Restoring a Model" do
  it "should have a model to restore to" do
    parent = Parent.new({name: "First Restore Test"})
    parent.save
    
    parent.versions.last.restore_to.should eq parent
  end
  
  it "should restore a model" do
    parent = Parent.find_by_name("First Restore Test")
    parent.name = "Updated Restore Test"
    
    parent.versions.last.restore
    Parent.find(parent.id).name.should eq "First Restore Test"
  end
  
  it "after a restore the last versions action should be restored" do
    parent = Parent.find_by_name("First Restore Test")
    parent.name = "Updated Restore Test"
    
    parent.versions.last.restore
    Parent.find(parent.id).versions.last.event.should eq "restore"
  end
  
  it "should restore a deleted version" do
    parent = Parent.find_by_name("First Restore Test")
    parent.destroy
    parent_id = parent.id

    version = Wikify.destroyed_versions(Parent).last
    version.restore
    
    parent = Parent.find_by_name("First Restore Test")
    parent.name.should eq "First Restore Test"
    parent.id.should eq parent_id
  end
end