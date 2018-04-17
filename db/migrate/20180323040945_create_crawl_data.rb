class CreateCrawlData < ActiveRecord::Migration[5.1]
  def change
    create_table :crawl_data do |t|

      t.string  :region
      t.string  :category
      t.string  :name
      t.string  :address
      t.string  :tags
      t.string  :is_inside
      t.string  :is_food_traditional
      t.string  :is_look_traditional
      t.string  :near_subway
      t.string  :x
      t.string  :y

      t.timestamps
    end
  end
end
