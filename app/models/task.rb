class Task < ActiveRecord::Base
  validates_presence_of :name
  belongs_to :category
  belongs_to :priority
  
end

