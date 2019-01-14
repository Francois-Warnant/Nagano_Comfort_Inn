# == Schema Information
#
# Table name: room_view_types
#
#  id           :integer          not null, primary key
#  room_id      :integer
#  view_type_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class RoomViewType < ActiveRecord::Base
  attr_accessible :room_id, :view_type_id

  belongs_to :room
  belongs_to :view_type
end
