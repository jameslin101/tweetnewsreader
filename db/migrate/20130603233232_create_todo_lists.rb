class CreateTodoLists < ActiveRecord::Migration
  def change
    create_table :todo_lists do |t|
      t.string :name
      t.string :completed_flag
      t.string :boolean

      t.timestamps
    end
  end
end
