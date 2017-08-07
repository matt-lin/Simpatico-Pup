class AddImpressionsCountToPup < ActiveRecord::Migration
  def change
    add_column :pups, :impressions_count, :int
  end
end
