class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :user_id
      t.string :crawl_datum_id
      t.string :title
      t.text :contents
      t.string :star
      t.timestamps
    end
  end
end
