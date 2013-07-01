class DropArticles < ActiveRecord::Migration
  def up
    drop_table :articles
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "Can't recover the deleted articles"
  end
end
