class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.text :open_response
      t.integer :rate_dog
      t.integer :breed_rating
      t.integer :breeder_rating
      t.integer :forum

      t.timestamps null: false
    end
  end
end
