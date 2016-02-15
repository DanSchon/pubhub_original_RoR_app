class CreatePubs < ActiveRecord::Migration
  def change
    create_table :pubs do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :title
      t.string :url
      t.text :content
      t.timestamps
    end
  end
end
