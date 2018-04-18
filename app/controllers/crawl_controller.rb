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
    def xytest
        require('nokogiri')
        doc = '37.402056,127.108212'
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
