# == Schema Information
#
# Table name: room_room_types
#
#  id           :integer          not null, primary key
#  room_id      :integer
#  room_type_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class RoomRoomTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
