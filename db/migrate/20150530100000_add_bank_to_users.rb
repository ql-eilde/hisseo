class AddBankToUsers < ActiveRecord::Migration
  def change
    add_column :users, :iban_number, :string
    add_column :users, :bic_number, :string
  end
end
