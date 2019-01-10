class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.string :type

      t.timestamps
    end
  end
end
