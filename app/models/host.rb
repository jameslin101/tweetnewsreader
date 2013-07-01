class Host < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true
  attr_accessible :name, :category

end
