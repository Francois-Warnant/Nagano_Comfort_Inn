# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  role_id                :string(255)
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
      self.assignments.create(role_id: 2)
    end
end
