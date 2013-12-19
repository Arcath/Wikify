require 'spec_helper'

describe "Model Update" do
  it "should create a version on update and set the event to :update" do
    parent = Parent.new({name: "First Update Test"})
    parent.save
    
    ffound = Parent.find_by_name("First Update Test")
    ffound.name = "Updated First Update Test"
    ffound.save
    
    sfound = Parent.find_by_name("Updated First Update Test")
    sfound.versions.count.should eq 2
    sfound.versions.last.data["name"].should eq "First Update Test"
    sfound.versions.last.event.should eq "update"
  end
  
  it "should create a second version after the first" do
    ffound = Parent.find_by_name("Updated First Update Test")
    ffound.name = "Second Update Test"
    ffound.save
    
    sfound = Parent.find_by_name("Second Update Test")
    sfound.versions.count.should eq 3
    sfound.versions[1].data["name"].should eq "First Update Test"
    sfound.versions.last.data["name"].should eq "Updated First Update Test"
  end
end