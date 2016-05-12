class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.string :title
      t.text :content
      t.references :user, index: true
      t.integer :version

      t.timestamps
    end
    add_foreign_key :wikis, :users
  end
end
