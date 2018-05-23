class CrawlDatum < ApplicationRecord
    has_many :posts
    has_many :crawl_data_thumbnails
end
