# == Schema Information
#
# Table name: personal_infos
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  first_name  :string(255)
#  last_name   :string(255)
#  address     :string(255)
#  country     :string(255)
#  phone_no    :string(255)
#  postal_code :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class PersonalInfoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
