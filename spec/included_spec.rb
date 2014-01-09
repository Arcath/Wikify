require 'spec_helper'

describe Parent do
  it "Should have the wikify method" do
    Parent._create_callbacks.length.should eq 2
    Parent._update_callbacks.length.should eq 2
    Parent._destroy_callbacks.length.should eq 1
  end
  
  it "should have the callback methods" do
    parent = Parent.new
    parent.methods.include?(:wikify_cache).should be_true
    parent.methods.include?(:wikify_update).should be_true
    parent.methods.include?(:wikify_create).should be_true
    parent.methods.include?(:wikify_destroy).should be_true
  end
  
  it "should have the relationship with versions" do
    parent = Parent.new
    parent.versions.count.should eq 0
  end
end