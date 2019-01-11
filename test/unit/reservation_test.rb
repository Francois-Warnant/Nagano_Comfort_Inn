# == Schema Information
#
# Table name: reservations
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  room_id        :integer
#  start_date     :datetime
#  end_date       :datetime
#  client_demands :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
