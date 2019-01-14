# == Schema Information
#
# Table name: reservations
#
#  id             :integer          not null, primary key
#  start_date     :datetime
#  end_date       :datetime
#  client_demands :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#

require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
