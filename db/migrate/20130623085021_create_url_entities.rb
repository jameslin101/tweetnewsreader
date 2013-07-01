class CreateUrlEntities < ActiveRecord::Migration
  def change
    create_table :url_entities do |t|
      t.integer :tweet_id, :limit => 8
      t.string  :expanded_url
      t.string  :fully_expanded_url
      t.integer :indice_start
      t.integer :indice_end
      t.timestamps
    end
  end
end
