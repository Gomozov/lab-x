# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  admin           :boolean
#  avatar          :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  pass            :integer
#  key             :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :avatar
  mount_uploader :avatar, AvatarUploader           
                                                   
  validates :name,  :presence => true,             
                    :length   => { :maximum => 50 }
  validates :email, :presence => true,             
                    :uniqueness => true,
                    :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
                                                   
  has_secure_password                              
  has_many :reports
  validates_presence_of :password

  def find_by_key (key)
    User.find_by_key(key)
  end

end
