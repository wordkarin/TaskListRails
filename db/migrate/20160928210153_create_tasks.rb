class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.date :completed_at
      t.boolean :completed

      t.timestamps null: false
    end
  end
end