module Wikify
  module Generators
    class MigrationGenerator < Rails::Generators::Base
      argument :model_name, :type => :string, :default => "versions"
      
      def generate_migration
        generate "migration", "create_wikify_#{model_name}", "resource_id:integer", "resource_type", "data:text", "event", "linked_child_resource_type", "linked_child_resource_id:integer", "linked_child:boolean", "comitter_id:integer", "created_at:datetime", "updated_at:datetime"
      end
    end
  end
end