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

migration 8, :create_retailers do
  up do
    create_table :dm_retailers do
      column :id,   Integer, :serial => true
      column :name, String, :size => 255
    end
  end
  
  down do
    drop_table :dm_retailers
  end
end

migration 9, :create_giftcards do
  up do
    create_table :giftcards do
      column :id,   Integer, :serial => true
      column :code, String, :size => 50
      column :dm_retailer_id, Integer
    end
  end

  down do
    drop_table :giftcards
  end
end

migration 10, :add_metadata_to_giftcards do
  up do
    modify_table :giftcards do
      add_column :constructed, "BOOLEAN"
      add_column :shipped, "BOOLEAN"
      add_column :registered, DateTime
      add_column :created_at, DateTime
      add_column :created_on, Date
    end
  end

  down do
    modify_table :giftcards do
      remove_column :constructed
      remove_column :shipped
      remove_column :registered
      remove_column :created_at
      remove_column :created_on
    end
  end
end

migration 11, :create_coupons do
  up do
    create_table :coupons do
      column :id,   Integer, :serial => true
      column :code, String, :size => 50
      column :information, String, :size => 100
      column :discount, Float
      column :created_at, DateTime
      column :created_on, Date
      column :giftcard_id, Integer
    end
  end

  down do
    drop_table :coupons
  end
end

migration 12, :add_name_and_email_to_giftcards do
  up do
    modify_table :giftcards do
      add_column :name, String, :size => 255
      add_column :email, String, :size => 255
    end
  end

  down do
    modify_table :giftcards do
      remove_column :name
      remove_column :email
    end
  end
end
#migrate_down!
migrate_up!
