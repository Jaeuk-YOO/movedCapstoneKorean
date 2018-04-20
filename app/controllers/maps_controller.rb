class MapsController < ApplicationController
    before_action :authenticate_user!
    def where_am_i
    end

    def recommend_test
        category_arr = ["쇼핑","카페","식당","명소"]
        current_user_select = current_user.user_selects.last
        @current_user_select_to_view = current_user.user_selects.last
        # current_user_select.location
        unless CrawlDatum.where("category":"쇼핑").sample(1).first == nil
            @rand_shopping = CrawlDatum.where("category":"쇼핑").sample(1).first
            @user_shopping = CrawlDatum.where("region":current_user_select.location).where("category":"쇼핑").sample(1).first
        end
        unless CrawlDatum.where("category":"카페").sample(1).first == nil
            @rand_cafe = CrawlDatum.where("category":"카페").sample(1).first
            @user_cafe = CrawlDatum.where("region":current_user_select.location).where("category":"카페").sample(1).first
        end
        unless CrawlDatum.where("category":"식당").sample(1).first == nil
            @rand_restaurant = CrawlDatum.where("category":"식당").sample(1).first
            @user_restaurant = CrawlDatum.where("region":current_user_select.location).where("category":"식당").sample(1).first
        end
        unless CrawlDatum.where("category":"명소").sample(1).first == nil
            @rand_sights = CrawlDatum.where("category":"명소").sample(1).first
            @user_sights = CrawlDatum.where("region":current_user_select.location).where("category":"명소").sample(1).first
        end
    end

    def test_latlng
    end

end
