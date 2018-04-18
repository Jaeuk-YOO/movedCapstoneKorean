class CreateExpressions < ActiveRecord::Migration[5.0]
  def change
    create_table :expressions do |t|
      t.string :crawl_data_id
      t.string :category #카페인지 쇼핑인지 명소인지 위의 항목과 연계
      t.string :type  #문화설명=="culture", 한국어 표현=="korean", 대화=="dialog"
      t.string :language, default: "korean" 
      t.string :about #해당 유닛에 대한 설명이 필요할때. 혹은 상황을 제시할 때. 소제목처럼.
      t.text :contents
      t.timestamps
    end
  end
end
