# == Schema Information
#
# Table name: sensors
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sensor < ActiveRecord::Base
  attr_accessible :name, :value

  validates :name, :presence => true
  validates :value, :presence => true

end

