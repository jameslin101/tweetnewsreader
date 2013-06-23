class Item < ActiveRecord::Base
  attr_accessible :completed_flag, :description

  scope :completed, where(:completed_flag => true)
  scope :incomplete, where(:completed_flag => false)


end
