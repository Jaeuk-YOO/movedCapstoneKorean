class CrawlController < ApplicationController
    before_action :authenticate_user!
    def data_rollback_upload #final xml파일을 크롤링합니다.
        require('nokogiri')
        target_xml = ["crawl_data_rollback_final.xml"]
        target_xml.each do |each_xml|
            seochon = Nokogiri::XML(File.open("public/"+each_xml))
            seochon.xpath("//store").each do |each_data|
                cd = CrawlDatum.new
                cd.region = each_data.xpath("region").inner_text
                cd.category = each_data.xpath("category").inner_text
                cd.name = each_data.xpath("name").inner_text
                cd.address = each_data.xpath("address").inner_text
                cd.tags = each_data.xpath("tags").inner_text
                cd.is_inside = each_data.xpath("is_inside").inner_text
                cd.is_food_traditional = each_data.xpath("is_food_traditional").inner_text
                cd.is_look_traditional = each_data.xpath("is_look_traditional").inner_text
                cd.near_subway = each_data.xpath("near_subway").inner_text
                cd.x = each_data.xpath("x").inner_text
                cd.y = each_data.xpath("y").inner_text
                cd.save
            end
        end
        redirect_to '/crawl/is_xml_crawl_right' #크롤링 데이터를 /chk에서 확인할 수 있도록 합니다.
    end


    def upload #xml파일을 크롤링합니다.
        require('nokogiri')
        target_xml = ["seochon_final.xml", "myungdong_final.xml", "hongdae_final.xml"]
        target_xml.each do |each_xml|
            seochon = Nokogiri::XML(File.open("public/"+each_xml))
            seochon.xpath("//store").each do |each_data|
                cd = CrawlDatum.new
                cd.region = each_xml.delete(".xml")
                cd.category = each_data.xpath("category").inner_text
                cd.name = each_data.xpath("name").inner_text
                cd.address = each_data.xpath("address").inner_text
                cd.tags = each_data.xpath("tags").inner_text
                cd.is_inside = each_data.xpath("is_inside").inner_text
                cd.is_food_traditional = each_data.xpath("is_food_traditional").inner_text
                cd.is_look_traditional = each_data.xpath("is_look_traditional").inner_text
                cd.near_subway = each_data.xpath("near_subway").inner_text
                cd.save
            end
        end
        redirect_to '/crawl/xml_crawl_chk' #크롤링 데이터를 /chk에서 확인할 수 있도록 합니다.
    end

    def upload2
        #unless CrawlDatum.where(address: params[:address_name]).take == true
            cd_saved = CrawlDatum.where(address: params[:address_name]).take
            puts params[:x]
            cd_saved.x = params[:x]
            cd_saved.y = params[:y]
            cd_saved.save
    end

    def upload2_repeated
        unless CrawlDatum.where(address: params[:address_name]).take == true
        end
    end
    
    def is_xml_crawl_right
        @cdchk = CrawlDatum.all
    end

    def xml_crawl_chk
        @cdchk = CrawlDatum.all
    end

    def marker
        @cdchk = CrawlDatum.all
    end

    def upload_where_i_am
        puts params[:x]
        puts params[:y]
    end

    def draw_marker
        @cd_shopping = CrawlDatum.where("category":"쇼핑").sample(1).first
        @cd_cafe = CrawlDatum.where("category":"카페").sample(1).first
        @cd_restaurant = CrawlDatum.where("category":"식당").sample(1).first
    end

    def thumbnail_collect_test
        
        CrawlDatum.all.each do |each_data|
            if each_data.crawl_data_thumbnails.take.nil?
                # 비어있으면 검색시작.

                # ===========================
                # bing API 영역
                
                require 'net/https'
                require 'uri'
                require 'json'

                # Replace the accessKey string value with your valid access key.
                accessKey = "ada2ac6174cc42d99ae6e070a0c6d6ef"

                uri  = "https://api.cognitive.microsoft.com"
                path = "/bing/v7.0/images/search"

                term = each_data.name

                if accessKey.length != 32 then
                    puts "Invalid Bing Search API subscription key!"
                    abort
                end

                uri = URI(uri + path + "?q=" + URI.escape(term))

                request = Net::HTTP::Get.new(uri)
                request['Ocp-Apim-Subscription-Key'] = accessKey

                response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
                    http.request(request)
                end

                result = JSON.parse(response.body) 
                thumbnailUrl = result["value"]
                    # >> thumbnailUrl = { thumbnailUrl : "http://어쩌고저쩌고" , thumbnailUrl : "http://어쩌고저쩌고"}
            
                # bing API 영역 끝
                # ===========================
                
                # data 저장 시작
                if  (each_data.crawl_data_thumbnails.where(crawl_datum_id: each_data.id).take.nil?) && (thumbnailUrl[9].nil? == false)
                    each_thumbnail = each_data.crawl_data_thumbnails.new
                    each_thumbnail.crawl_datum_id = each_data.id
                    each_thumbnail.src_1 = thumbnailUrl[0]['thumbnailUrl']
                    each_thumbnail.src_2 = thumbnailUrl[1]['thumbnailUrl']
                    each_thumbnail.src_3 = thumbnailUrl[2]['thumbnailUrl']
                    each_thumbnail.src_4 = thumbnailUrl[3]['thumbnailUrl']
                    each_thumbnail.src_5 = thumbnailUrl[4]['thumbnailUrl']
                    each_thumbnail.src_6 = thumbnailUrl[5]['thumbnailUrl']
                    each_thumbnail.src_7 = thumbnailUrl[6]['thumbnailUrl']
                    each_thumbnail.src_8 = thumbnailUrl[7]['thumbnailUrl']
                    each_thumbnail.src_9 = thumbnailUrl[8]['thumbnailUrl']
                    each_thumbnail.src_10 = thumbnailUrl[9]['thumbnailUrl']
                    each_thumbnail.save
                elsif (each_data.crawl_data_thumbnails.where(crawl_datum_id: each_data.id).take.nil? == false) && (thumbnailUrl[9].nil? == false)
                    each_thumbnail = each_data.crawl_data_thumbnails.where(crawl_datum_id: each_data.id).take
                    each_thumbnail.src_1 = thumbnailUrl[0]['thumbnailUrl']
                    each_thumbnail.src_2 = thumbnailUrl[1]['thumbnailUrl']
                    each_thumbnail.src_3 = thumbnailUrl[2]['thumbnailUrl']
                    each_thumbnail.src_4 = thumbnailUrl[3]['thumbnailUrl']
                    each_thumbnail.src_5 = thumbnailUrl[4]['thumbnailUrl']
                    each_thumbnail.src_6 = thumbnailUrl[5]['thumbnailUrl']
                    each_thumbnail.src_7 = thumbnailUrl[6]['thumbnailUrl']
                    each_thumbnail.src_8 = thumbnailUrl[7]['thumbnailUrl']
                    each_thumbnail.src_9 = thumbnailUrl[8]['thumbnailUrl']
                    each_thumbnail.src_10 = thumbnailUrl[9]['thumbnailUrl']
                    each_thumbnail.save
                end

            end
        end
    end

    def thumbnail_collect
        
        CrawlDatum.all.each do |each_data|
            if each_data.crawl_data_thumbnails.take.nil?
                # 비어있으면 검색시작.

                # ===========================
                # bing API 영역
                
                require 'net/https'
                require 'uri'
                require 'json'

                # Replace the accessKey string value with your valid access key.
                accessKey = "ada2ac6174cc42d99ae6e070a0c6d6ef"

                uri  = "https://api.cognitive.microsoft.com"
                path = "/bing/v7.0/images/search"

                term = each_data.name

                if accessKey.length != 32 then
                    puts "Invalid Bing Search API subscription key!"
                    abort
                end

                uri = URI(uri + path + "?q=" + URI.escape(term))

                request = Net::HTTP::Get.new(uri)
                request['Ocp-Apim-Subscription-Key'] = accessKey

                response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
                    http.request(request)
                end

                result = JSON.parse(response.body) 
                thumbnailUrl = result["value"]
                    # >> thumbnailUrl = { thumbnailUrl : "http://어쩌고저쩌고" , thumbnailUrl : "http://어쩌고저쩌고"}
            
                # bing API 영역 끝
                # ===========================
                 
                thumbnailUrl.each_with_index do |x, index|
                    if index < 10
                        # 저장 시작
                        each_thumbnail = each_data.crawl_data_thumbnails.new
                        each_thumbnail.crawl_datum_id = each_data.id
                        src_arr = [each_thumbnail.src_1, each_thumbnail.src_2, each_thumbnail.src_3, each_thumbnail.src_4, each_thumbnail.src_5, each_thumbnail.src_6, each_thumbnail.src_7, each_thumbnail.src_8, each_thumbnail.src_9, each_thumbnail.src_10]
                        
                        src_arr[index] = x['thumbnailUrl']
                        each_thumbnail.save
                    end
                end 

            end
        end
        # each_data 체크 끝.
    end

    def crawl_supply
        CrawlDatum.all.each do |each_data|
            if each_data.region == "hongdae_fina"
                each_data.region = "hongdae"
                each_data.save
            elsif each_data.region == "yungdong_fina"
                each_data.region = "myeongdong"
                each_data.save
            else each_data.region == "seochon_fina"
                each_data.region = "seochon"
                each_data.save
            end
        end
    end
end
