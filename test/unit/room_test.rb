# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  type_id    :integer
#  view_id    :integer
#  floor_no   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  room_no    :integer
#

require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
