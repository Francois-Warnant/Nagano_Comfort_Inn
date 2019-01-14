class ViewType < ActiveRecord::Base
  attr_accessible :type

  has_many :room_view_types
  has_many :rooms, through: :room_view_types
end
