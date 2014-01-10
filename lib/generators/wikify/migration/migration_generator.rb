module Wikify
  module Generators
    class MigrationGenerator < Rails::Generators::Base
      argument :model_name, :type => :string, :default => "versions"
      
      def generate_migration
        generate "migration", "create_#{model_name}", "resource_id:integer", "resource_type", "data:text", "event", "linked_child_resource_type", "linked_child_resource_id:integer", "linked_child:boolean", "comitter_id:integer"
      end
    end
  end
end