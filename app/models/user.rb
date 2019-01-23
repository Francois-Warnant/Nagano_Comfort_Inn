# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string(255)
#  last_name              :string(255)
#  address                :string(255)
#  city                   :string(255)
#  country                :string(255)
#  postal_code            :string(255)
#  phone_number           :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_create :assign_default_role

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_id, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :reservations, dependent: :destroy

  has_many :assignments
  has_many :roles, through: :assignments

  def reserve(r_params)
    arrival = Date.new r_params["start_date(1i)",].to_i, r_params["start_date(2i)",].to_i, r_params["start_date(3i)",].to_i
    depart = Date.new r_params["end_date(1i)",].to_i, r_params["end_date(2i)",].to_i, r_params["end_date(3i)",].to_i
    demands = r_params["client_demands"]

    reservations.build({start_date: arrival, end_date: depart, client_demands: demands})
  end

  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end

  private
    def assign_default_role
      if User.count < 1 || User.count == nil #TEMP
        self.assignments.create(role_id: 1)
      else
        self.assignments.create(role_id: 2)
      end
    end
end
