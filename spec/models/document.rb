class Document < ActiveRecord::Base
  wikify({:assoc_name => :revisions,
      :assoc_as => :thing,
      assoc_model: "Revision"})
end