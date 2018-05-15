# frozen_string_literal: true

class CreateUser < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_hash

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
