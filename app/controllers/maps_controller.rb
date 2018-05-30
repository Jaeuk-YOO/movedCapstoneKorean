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

        # modal의 리뷰 post chk
        #unless Post.where("crawl_datum_id":@user_restaurant.id).first == nil
        #    @reviews = Post.where("crawl_datum_id":@user_restaurant.id).sample(3)
        #end

        # user_translate_관련
        unless current_user.user_translates.nil?
            @translate_done = current_user.user_translates.last
        end
        
        # modal 관련
        @expression_korean_cafe_order = {"따뜻한 아메리카노 한 잔 주세요.":"Please give me 1 hot coffee", "아이스 아메리카노 두 잔 주세요.":"Please give me 2 ice coffees", "카페인 없는 음료 있어요?":"Do you have non-caffeinated drinks?", "여기서 먹고 갈게요.":"I'll drink it here.", "테이크 아웃할게요.":"I'd like this to go", "영수증은 버려주세요.":"Please throw away my receipt", "음료 추천해주실 수 있나요?":"Can you recommend a drink?"}
        @expression_korean_cafe_service = {"와이파이 되나요?":"Do you have wifi?", "와이파이 비밀번호가 뭐예요?":"What's the wifi password?", "콘센트 있어요?":"Is there an outlet?", "콘센트 어디에 있어요?":"Where are your electrical outlets?"}
        @expression_korean_cafe_experience = {"어떻게 이용하나요?":"How can I use this? play?", "한 시간에 얼마인가요?":"How much is it per hour?", "짐은 어디에 두나요? 짐은 어디에 보관하나요?":"Where can I keep my luggage?", "한 시간 더 이용하고 싶어요. 추가 요금이 얼마인가요?":"I'd like to play it for one more hour. (how much is it cost?) How much extra would it be"}
    
        @expression_korean_shopping_order = {}
        
        #이미지 서치 합치기 테스트
        #.each do |each_data|
        #if each_data.crawl_data_thumbnails.where(crawl_datum_id: each_data.id).take.nil?
        # if @user_restaurant.crawl_data_thumbnails.nil? 
        
            require 'net/https'
            require 'uri'
            require 'json'

            # **********************************************
            # *** Update or verify the following values. ***
            # **********************************************

            # Replace the accessKey string value with your valid access key.
            accessKey = ""

            # Verify the endpoint URI.  At this writing, only one endpoint is used for Bing
            # search APIs.  In the future, regional endpoints may be available.  If you
            # encounter unexpected authorization errors, double-check this value against
            # the endpoint for your Bing Search instance in your Azure dashboard.
            thumbnail_target = [@user_cafe.name, @user_restaurant.name, @user_shopping.name, @user_sights.name]
            @thumbnail_result = []
            
            thumbnail_target.each do |each_term|

            uri  = "https://api.cognitive.microsoft.com"
            path = "/bing/v7.0/images/search"
            
                term = each_term
                puts each_term
                if accessKey.length != 32 then
                    puts "Invalid Bing Search API subscription key!"
                    puts "Please paste yours into the source code."
                    abort
                end

                uri = URI(uri + path + "?q=" + URI.escape(term))

                #puts "Searching images for: " + term

                request = Net::HTTP::Get.new(uri)
                request['Ocp-Apim-Subscription-Key'] = accessKey

                response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
                    http.request(request)
                end

                #puts "\nRelevant Headers:\n\n"
                #response.each_header do |key, value|
                #    # header names are coerced to lowercase
                #    if key.start_with?("bingapis-") or key.start_with?("x-msedge-") then
                #        puts key + ": " + value
                #    end
                #end

                #puts "\nJSON Response:\n\n"
                #puts JSON::pretty_generate(JSON(response.body))

                result = JSON.parse(response.body) 
                puts result
                if result["value"] == []     
                    @thumbnail_result.push("")
                else
                    @thumbnail_result.push(result["value"][0])
                end
            end
                puts @thumbnail_result
                # @thumbnailUrl = result["value"]
        #elsif @user_restaurant.crawl_data_thumbnails.nil?  == false
        #    @user_restaurant_stored = @user_restaurant.crawl_data_thumbnails.all
        #end
    end


    def test_latlng
    end

    def user_translate
        unless current_user.user_translates.nil?
            @translate_done = current_user.user_translates.last
        end
    end

    def user_translate_result
        unless current_user.user_translates.nil?
            @translate_done = current_user.user_translates.last
        end
    end

    def translate
        current_user_translate = current_user.user_translates.new
        current_user_translate.input = params[:target_text]
        current_user_translate.save

        require 'net/https'
        require 'uri'
        require 'cgi'

        # **********************************************
        # *** Update or verify the following values. ***
        # **********************************************

        # Replace the key string value with your valid subscription key.
        key = ''

        host = 'https://api.microsofttranslator.com'
        path = '/V2/Http.svc/Translate'

        target = 'ko'
        text = params[:target_text]

        params = '?to=' + target + '&text=' + CGI.escape(text)
        uri = URI (host + path + params)

        request = Net::HTTP::Get.new(uri)
        request['Ocp-Apim-Subscription-Key'] = key

        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
            http.request (request)
        end

        @result = Hash.from_xml(response.body) 
        current_user_translate_done = current_user.user_translates.last
        unless @result['string'] =='{"xmlns"=>"http://schemas.microsoft.com/2003/10/Serialization/"}'
            current_user_translate_done.output = @result['string']
            current_user_translate_done.save
        end
        return @result['string']

        redirect_to '/maps/user_translate_result'
    end

    def translate_result
    end
    
    def detail_image
        require 'net/https'
        require 'uri'
        require 'json'

        # **********************************************
        # *** Update or verify the following values. ***
        # **********************************************

        # Replace the accessKey string value with your valid access key.
        accessKey = ""

        # Verify the endpoint URI.  At this writing, only one endpoint is used for Bing
        # search APIs.  In the future, regional endpoints may be available.  If you
        # encounter unexpected authorization errors, double-check this value against
        # the endpoint for your Bing Search instance in your Azure dashboard.

        uri  = "https://api.cognitive.microsoft.com"
        path = "/bing/v7.0/images/search"

        @user_restaurant = CrawlDatum.where("category":"식당").sample(1).first
        term = @user_restaurant.name

        if accessKey.length != 32 then
            puts "Invalid Bing Search API subscription key!"
            puts "Please paste yours into the source code."
            abort
        end

        uri = URI(uri + path + "?q=" + URI.escape(term))

        #puts "Searching images for: " + term

        request = Net::HTTP::Get.new(uri)
        request['Ocp-Apim-Subscription-Key'] = accessKey

        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
            http.request(request)
        end

        #puts "\nRelevant Headers:\n\n"
        #response.each_header do |key, value|
        #    # header names are coerced to lowercase
        #    if key.start_with?("bingapis-") or key.start_with?("x-msedge-") then
        #        puts key + ": " + value
        #    end
        #end

        #puts "\nJSON Response:\n\n"
        #puts JSON::pretty_generate(JSON(response.body))

        result = JSON.parse(response.body) 
        @thumbnailUrl = result["value"][0]["thumbnailUrl"]
        
    end

    def review_create
        new_post = Post.new
        new_post.user_id = current_user.id
        new_post.crawl_datum_id = 
        new_post.title = params[:title]
        new_post.contents = params[:contents]
        new_post.star = params[:star]
        new_post.save
    end
end
