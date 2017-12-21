module BuriAuth
  class User < BuriAuth.configuration.resource_class.constantize
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
