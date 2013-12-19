module Wikify
  module Generators
    class MigrationGenerator < Rails::Generators::Base
      argument :model_name, :type => :string, :default => "versions"
      
      def generate_migration
        generate "migration", "create_#{model_name}", "resource_id:integer", "resource_type", "data:text", "event"
      end
    end
  end
end