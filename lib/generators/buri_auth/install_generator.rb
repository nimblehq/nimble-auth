module BuriAuth
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../../templates', __FILE__)

    CUSTOM_CONTROLLERS = {
      omniauth_callbacks: 'buri_auth/omniauth_callbacks',
      sessions: 'buri_auth/sessions'
    }.freeze

    CUSTOM_PATH = {
      sign_in: 'signin',
      sign_up: 'signup',
      sign_out: 'signout'
    }.freeze

    def setup
      extend_migrations
      extend_models
      add_initializer_template
      mount_engine
    end

    private

    def extend_models
      extend_user
      extend_identity
    end

    def extend_migrations
      extend_user_migrations
      extend_identity_migrations
    end

    def add_initializer_template
      copy_file 'initializer.rb', 'config/initializers/buriauth.rb'
    end

    def mount_engine
      inject_into_file 'config/routes.rb', after: "# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html\n" do
        "\tmount BuriAuth::Engine, at: '/auth'\n"
      end
    end

    def extend_user
      copy_file 'user.rb', 'app/models/user.rb' unless Object.const_defined?('User')
    end

    def extend_identity
      copy_file 'identity.rb', 'app/models/identity.rb' unless Object.const_defined?('Identity')
    end

    def extend_user_migrations
      return generate_edit_users_table_migrations if user_table_exists?

      generate_create_users_table_migrations
    end

    def extend_identity_migrations
      return generate_edit_identities_table_migrations if identity_table_exists?

      generate_create_identities_table_migrations
    end

    def generate_create_users_table_migrations
      copy_file 'migrations/create_users_table.rb', "db/migrate/#{current_timestamp}_create_users.rb"
    end

    def generate_create_identities_table_migrations
      copy_file 'migrations/create_identities_table.rb', "db/migrate/#{current_timestamp}_create_identities.rb"
    end

    def generate_edit_users_table_migrations
      copy_file 'migrations/edit_users_table.rb', "db/migrate/#{current_timestamp}_edit_users.rb"
    end

    def generate_edit_identities_table_migrations
      copy_file 'migrations/edit_identities_table.rb', "db/migrate/#{current_timestamp}_edit_identities.rb"
    end

    def user_table_exists?
      ActiveRecord::Base.connection.table_exists? 'users'
    end

    def identity_table_exists?
      ActiveRecord::Base.connection.table_exists? 'identities'
    end

    def current_timestamp
      Time.now.utc.strftime("%Y%m%d%H%M%S").to_i + Random.rand(10)
    end
  end
end
