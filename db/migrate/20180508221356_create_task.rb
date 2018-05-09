class CreateTask < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :description
      t.timestamp :start
      t.timestamp :end

      t.timestamps null: false
    end
  end
end
