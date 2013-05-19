require 'dm-migrations/migration_runner'
require_relative '../../config/datamapper_setup'

DataMapper::Logger.new(STDOUT, :debug)
DataMapper.logger.debug( "Starting Migration" )

migration 1, :create_orders_table do
  up do
    create_table :orders do
      column :id,   Integer, :serial => true
      column :name, String, :limit => 255
      column :email, String, :limit => 255
      column :country, String, :limit => 255
      column :city, String, :limit => 255
      column :street, String, :limit => 255
      column :postal_code, String, :limit => 255
      column :token, String, :limit => 255
      column :wood_type, String, :limit => 255
      column :type_of_purchase, String, :limit => 255
    end
  end

  down do
    drop_table :orders
  end
end

migrate_up!
