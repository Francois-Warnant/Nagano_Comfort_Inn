class RoomViewType < ActiveRecord::Base
  attr_accessible :room_id, :view_type_id

  belongs_to :room
  belongs_to :view_type
end
