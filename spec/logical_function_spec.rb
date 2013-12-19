# This is a worked example that appears in the readme except with shoulds to make sure that it works as planned
require 'spec_helper'

describe "Working logically" do
  it "should behave like we expect" do
    # First lets create a new object
    parent = Parent.new
    parent.name = "david" # Lets set the name
    parent.save # And save that record
    
    parent_id = parent.id # We will need this later
    
    parent.versions.count.should eq 1 # We should now have 1 version
    parent.versions.first.event.should eq "create" # that was created when we created the record
    parent.versions.first.data.should eq Hash.new # and has an empty hash for its data
    
    # Its a new day and we want to change "david" to "David"
    david = Parent.find(parent_id)
    david.name = "David"
    david.save
    
    david.versions.count.should eq 2 # We should now have a new version
    david.versions.last.event.should eq "update" # that was an update
    david.versions.last.data["name"].should eq "david" # and has the old name in the data hash
    
    # Its another day and we make another change
    david = Parent.find(parent_id)
    david.name = "Dav1d"
    david.save
    
    david.versions.count.should eq 3 # We should now have a new version
    david.versions.last.event.should eq "update" # that was an update
    david.versions.last.data["name"].should eq "David" # and has the old name in the data hash
    
    # Its another day and we want to restore the version with David
    david = Parent.find(parent_id)
    david.versions.last.restore # Restore the last version
    
    david = Parent.find(parent_id)
    david.versions.count.should eq 4 # We should now have a new version
    david.versions.last.event.should eq "restore" # that was an update
    david.versions.last.data["name"].should eq "Dav1d" # and has the old name in the data hash
    david.name.should eq "David" # The name should have been restored
    
    # David has died so its time to delete his record
    david = Parent.find(parent_id)
    david.destroy
    
    # Whoops he wasn't dead just resting his heart time to restore his record
    david_version = Wikify.destroyed_versions(Parent, parent_id).last
    david_version.event.should eq "destroy" # The last thing to happen to david should be destroy
    david_version.restore
    
    david = Parent.find(parent_id)
    david.name.should eq "David" # And now hes back! and at the same ID as before!
  end
end