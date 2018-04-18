class CreateUserGeocodes < ActiveRecord::Migration[5.0]
  def change
    create_table :user_geocodes do |t|
      t.string :user_id
      t.string :user_x
      t.string :user_y
      t.timestamps
    end
  end
end
