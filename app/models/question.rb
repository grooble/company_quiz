# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  qn         :string(255)
#  correct    :string(255)
#  option1    :string(255)
#  option2    :string(255)
#  option3    :string(255)
#  category   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ActiveRecord::Base

  validates :qn, presence: true, length: { minimum: 12 }
  validates :correct, presence: true
  validates :option1, presence: true
  validates :option2, presence: true
  validates :option3, presence: true

  attr_accessible :category, :correct, :option1, :option2, :option3, :qn
end
