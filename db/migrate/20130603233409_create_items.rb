class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :description
      t.boolean :completed_flag
      t.integer :todo_list_id
      
      t.timestamps
    end
  end
end
