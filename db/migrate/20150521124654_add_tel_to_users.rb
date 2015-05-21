class AddTelToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tel_number, :string
  end
end
