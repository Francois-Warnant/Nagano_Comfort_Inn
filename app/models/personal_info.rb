class PersonalInfo < ActiveRecord::Base
  attr_accessible :address, :country, :first_name, :last_name, :phone_no, :postal_code, :user_id
end
