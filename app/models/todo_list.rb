class TodoList < ActiveRecord::Base
  attr_accessible :boolean, :completed_flag, :name

  has_many :items, :dependent => :destroy
  accepts_nested_attributes_for :items

  def completed_items
    Item.where("completed_flag = ?", true)
  end

  def incomplete_items
    items.select{|i| i.completed_flag == false}
  end

end
