# == Schema Information
#
# Table name: view_types
#
#  id         :integer          not null, primary key
#  view_type  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ViewType < ActiveRecord::Base
  attr_accessible :view_type
end
