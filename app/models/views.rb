# == Schema Information
#
# Table name: views
#
#  id         :integer          not null, primary key
#  type       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Views < ActiveRecord::Base
  attr_accessible :type
end
