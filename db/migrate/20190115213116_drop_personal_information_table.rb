class DropPersonalInformationTable < ActiveRecord::Migration
  def up
    drop_table :personal_infos
  end

  def down
    create_table :personal_infos do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :country
      t.string :phone_no
      t.string :postal_code

      t.timestamps
    end
  end
end
