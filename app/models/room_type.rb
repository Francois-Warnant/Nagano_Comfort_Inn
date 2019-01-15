# == Schema Information
#
# Table name: room_types
#
#  id         :integer          not null, primary key
#  room_type  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RoomType < ActiveRecord::Base
  attr_accessible :room_type
end
