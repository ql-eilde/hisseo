class AddFieldsToListings < ActiveRecord::Migration
  def change
    add_column :listings, :departure, :string
    add_column :listings, :arrival, :string
  end
end
