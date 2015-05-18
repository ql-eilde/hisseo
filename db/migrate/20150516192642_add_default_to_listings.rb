class AddDefaultToListings < ActiveRecord::Migration
  def self.up
    change_column :listings, :compte_passager, :integer, :default => 1
  end

  def self.down
    # You can't currently remove default values in Rails
    raise ActiveRecord::IrreversibleMigration, "Can't remove the default"
  end
end
