Rails.application.configure do
  config.after_initialize do

    # Extend the parent Model class
    BuriAuth.configuration.resource_class.constantize.class_eval do
      devise :database_authenticatable,
             :registerable,
             :recoverable,
             :rememberable,
             :trackable,
             :validatable,
             :confirmable,
             :lockable,
             :timeoutable
    end
  end
end