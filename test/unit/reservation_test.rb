# == Schema Information
#
# Table name: reservations
#
#  id             :integer          not null, primary key
#  client_demands :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#  nb_rooms       :integer
#

require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
