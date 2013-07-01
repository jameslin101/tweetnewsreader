class CreateHostCategories < ActiveRecord::Migration
  def change
    create_table :host_categories do |t|
      t.string :host
      t.string :category

      t.timestamps
    end
  end
end
