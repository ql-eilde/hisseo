class ChangeListings < ActiveRecord::Migration
  def up
  	change_column_default :listings, :compte_passager, 0
  end

  def down
  	change_column_default :listings, :compte_passager, nil
  end
end
