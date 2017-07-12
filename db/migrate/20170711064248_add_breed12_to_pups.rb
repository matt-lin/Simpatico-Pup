class AddBreed12ToPups < ActiveRecord::Migration
  def change
    add_column :pups, :breed_1, :integer
    add_column :pups, :breed_2, :integer
  end
end
