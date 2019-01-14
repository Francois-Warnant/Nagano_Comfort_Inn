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

class Reservation < ActiveRecord::Base
  attr_accessible :client_demands, :end_date, :start_date, :user_id

  belongs_to :user

  validates :user_id, presence: true
end
