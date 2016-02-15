class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :pub_id
      t.text :body
      t.timestamps
    end
  end
end
