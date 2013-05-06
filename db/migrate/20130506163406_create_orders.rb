class CreateOrders < ActiveRecord::Migration
  def up
    create_table :orders do |t|
      t.string :name
      t.string :email
      t.string :country
      t.string :city
      t.string :street
      t.string :postal_code
      t.string :token
      t.string :wood_type
      t.string :type
    end
  end

  def down
    drop_table :orders
  end
end
