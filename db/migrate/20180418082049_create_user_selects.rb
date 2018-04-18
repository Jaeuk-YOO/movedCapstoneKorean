class CreateUserSelects < ActiveRecord::Migration[5.0]
  def change
    create_table :user_selects do |t|
      t.string :user_id
      t.string :location
      t.string :feel
      t.string :food_traditional
      t.string :look_traditional
      t.string :inside
      t.timestamps
    end
  end
end
