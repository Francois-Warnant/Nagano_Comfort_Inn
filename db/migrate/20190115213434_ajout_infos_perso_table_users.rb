class AjoutInfosPersoTableUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :address, :string
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :postal_code, :string
    add_column :users, :phone_number, :string
  end
end
