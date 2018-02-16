class CreateIdentities < ActiveRecord::Migration[5.1]
  def change
    create_table :identities do |t|
      ## Attributes
      t.string :uid, null: false
      t.string :provider, null: false
      t.string :oauth_token, null: false
      t.string :oauth_secret
      t.datetime :expires_at
      t.timestamps null: false

      ## Associations
      t.belongs_to :user, foreign_key: true
    end

    add_index :identities, [:provider, :uid], unique: true
  end
end
