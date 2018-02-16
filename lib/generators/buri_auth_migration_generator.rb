class BuriAuthMigrationGenerator < Rails::Generators::Base
  def create_migration_file
    `bin/rails buri_auth:install:migrations`
  end
end
