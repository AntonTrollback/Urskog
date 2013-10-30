require 'data_mapper'
require 'dm-migrations/migration_runner'
require_relative '../../config/datamapper_setup'

DataMapper::Logger.new(STDOUT, :debug)
DataMapper.logger.debug( "Starting Migration" )

migration 1, :create_orders_table do
  up do
    create_table :orders do
      column :id,   Integer, :serial => true
      column :name, String, :size => 255
      column :email, String, :size => 255
      column :country, String, :size => 255
      column :city, String, :size => 255
      column :street, String, :size => 255
      column :postal_code, String, :size => 255
      column :token, String, :size => 255
      column :wood_type, String, :size => 255
      column :type_of_purchase, String, :size => 255
    end
  end

  down do
    drop_table :orders
  end
end

migration 2, :add_data_to_orders do
  up do
    modify_table :orders do
      add_column :price, String, :limit => 50
      add_column :board, String, :limit => 255
    end
  end
end

migration 3, :add_created_at_to_orders do
  up do
    modify_table :orders do
      add_column :created_at, DateTime
      add_column :created_on, Date
    end
  end
end

migration 4, :add_payment_went_wrong_flag_to_orders do
  up do
    modify_table :orders do
      add_column :payment_went_wrong, "BOOLEAN"
    end
  end
end

migration 5, :add_receipt_went_wrong_flag_to_orders do
  up do
    modify_table :orders do
      add_column :receipt_went_wrong, "BOOLEAN"
    end
  end
end

migration 6, :add_receipt_went_wrong_err_msg_to_orders do
  up do
    modify_table :orders do
      add_column :receipt_went_wrong_msg, String, :limit => 255
    end
  end
end

migration 7, :phone_number_to_orders do
  up do
    modify_table :orders do
      add_column :phone_number, String, :limit => 255
    end
  end
end

migration 8, :add_users do
  up do
    create_table :users do
      column :id,   Integer, :serial => true
      column :email, String, :size => 255
      column :password, String, :size => 255
    end
  end

  down do
    drop_table :users
  end
end

migrate_up!
