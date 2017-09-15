class AddImpressionsCountToBreeder < ActiveRecord::Migration
  def change
    add_column :breeders, :impressions_count, :int
  end
end
