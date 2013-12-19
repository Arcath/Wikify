require 'spec_helper'

describe "With custom config" do
  it "should set the assosiation name" do
    doc = Document.new
    doc.revisions.count.should eq 0
  end
  
  it "should record a version for create/update" do
    Document.create!({title: "Foo"})
    doc = Document.find_by_title("Foo")
    doc.title = "Bar"
    doc.save
    
    doc.revisions.count.should eq 2
  end
  
  it "should let you restore a version" do
    doc = Document.find_by_title("Bar")
    doc.revisions.last.restore
    
    doc = Document.find_by_title("Foo")
    doc.title.should eq "Foo"
  end
end