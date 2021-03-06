class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.timestamps
      t.string :email
      t.boolean :active, :default => false, :null => false
      t.string :crypted_password
      t.string :password_salt
      t.string :username
      t.string :perishable_token, :nill => false
      t.string :persistence_token, :null => false
      t.integer :login_count, :default => 0, :null => false
      t.datetime :last_request_at
      t.datetime :last_login_at
      t.datetime :current_login_at
      t.string :last_login_ip
      t.string :current_login_ip

      t.string :last_name, :null => true
      t.string :first_name, :null => true
      t.string :middle_name, :null => true

      t.string :role

      t.date :date_of_birth

      t.string :gender
      
      t.datetime :blocked_at, :null => true
      t.datetime :released_at, :null => true
      
      t.integer :posts_count, :default => 0
      t.integer :comments_count, :default => 0

      t.integer :reputation, :default => 1
      t.integer :power, :default => 1

    end

    add_index :users, :email
    add_index :users, :persistence_token
    add_index :users, :last_request_at
    add_index :users, :reputation
  end

  def self.down
    remove_index :users, :email
    remove_index :users, :persistence_token
    remove_index :users, :last_request_at
    remove_index :users, :reputation

    drop_table :users
  end
end
