class CreateCrawlDataThumbnails < ActiveRecord::Migration[5.0]
  def change
    create_table :crawl_data_thumbnails do |t|

      t.string :crawl_datum_id
      t.string :src_1
      t.string :src_2
      t.string :src_3
      t.string :src_4
      t.string :src_5
      t.string :src_6
      t.string :src_7
      t.string :src_8
      t.string :src_9
      t.string :src_10

      t.timestamps
    end
  end
end
