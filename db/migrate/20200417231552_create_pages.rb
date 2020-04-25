class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.references :user
      t.integer :position
      t.string :kind
      t.string :name
      t.string :title
      t.text :body
      t.timestamps
    end
  end
end
