class Changenameonorders < ActiveRecord::Migration
  def up
    rename_column :orders, :type, :type_of_purchase
  end

  def down
    rename_column :orders, :type_of_purchase, :type
  end
end
