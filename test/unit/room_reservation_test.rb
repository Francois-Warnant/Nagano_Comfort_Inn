# == Schema Information
#
# Table name: room_reservations
#
#  id             :integer          not null, primary key
#  reservation_id :integer
#  room_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  start_date     :datetime
#  end_date       :datetime
#

require 'test_helper'

class RoomReservationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
