class CreateUserTranslates < ActiveRecord::Migration[5.0]
  def change
    create_table :user_translates do |t|
      t.string :user_id
      t.string :input
      t.string :output
      t.timestamps
    end
  end
end
