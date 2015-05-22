class AddSpecsToListings < ActiveRecord::Migration
  def change
    add_column :listings, :type_bateau, :string
    add_column :listings, :bagages, :string
  end
end
