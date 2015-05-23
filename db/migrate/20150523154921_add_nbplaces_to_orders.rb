class AddNbplacesToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :nb_places, :integer
  end
end
