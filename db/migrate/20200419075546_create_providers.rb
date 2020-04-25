class CreateProviders < ActiveRecord::Migration[6.0]
  def change
    create_table :providers do |t|
      t.references :user
      t.string :type
      t.string :api_key
      t.string :api_secret
      t.string :token
      t.string :secret
      t.string :username
      t.boolean :repost
      t.timestamps
    end
  end
end
