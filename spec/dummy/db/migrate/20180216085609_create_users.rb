class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      ## Attributes
      t.string :first_name
      t.string :last_name
      t.text :avatar
      t.text :location
      t.timestamps null: false

      ## Database authenticatable
      t.string :email, unique: true, null: false
      t.string :username, unique: true
      t.string :encrypted_password, null: false, default: ''

      ## Confirmable
      t.string   :confirmation_token, unique: true
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
    end
  end
end
