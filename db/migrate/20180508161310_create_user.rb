# frozen_string_literal: true

class CreateUser < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false
      t.string :password_hash,      null: false

      t.timestamps null: false
    end

    add_index :users, :email,       unique: true
  end
end
