class AddSearchBreederToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :search_breeder, :integer
  end
end
