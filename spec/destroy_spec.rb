require 'spec_helper'

describe "Model Destroy" do
  it "should record a destroy" do
    Wikify.destroyed_versions(Parent).count.should eq 0
    
    parent = Parent.new({name: "First Destory Test"})
    parent.save
    
    parent.destroy
    
    Wikify.destroyed_versions(Parent).count.should eq 1
    
    old_version = Wikify.destroyed_versions(Parent).last
    old_version.data.should eq parent.attributes
  end
end