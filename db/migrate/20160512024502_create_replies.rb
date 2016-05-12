class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.string :title
      t.text :content
      t.references :user, index: true
      t.references :wiki, index: true

      t.timestamps
    end
    add_foreign_key :replies, :users
    add_foreign_key :replies, :wikis
  end
end
