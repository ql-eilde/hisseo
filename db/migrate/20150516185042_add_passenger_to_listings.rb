class AddPassengerToListings < ActiveRecord::Migration
  def change
    add_column :listings, :nombre_passager, :integer
    add_column :listings, :compte_passager, :integer
  end
end
