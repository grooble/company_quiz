# == Schema Information
#
# Table name: takens
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  question_id :integer
#  correct     :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Taken < ActiveRecord::Base
  attr_accessible :correct, :question_id, :user_id
  belongs_to :user
  belongs_to :question
  
  validates :user_id, presence: true
  validates :question_id, presence: true
  
end
