class AddHostNameToUrlEntity < ActiveRecord::Migration
  def change
    add_column :url_entities, :host_name, :string
  end
end
