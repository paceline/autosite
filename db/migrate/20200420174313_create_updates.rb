class CreateUpdates < ActiveRecord::Migration[6.0]
  def change
    create_table :updates do |t|
      t.string :originalid
      t.references :provider
      t.string :heading
      t.text :content
      t.string :link
      t.datetime :posted_on
    end
  end
end
