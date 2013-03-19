class Taken < ActiveRecord::Base
  attr_accessible :correct, :question_id, :user_id
  belongs_to :user
  
  validates :user_id, presence: true
  validates :question_id, presence: true
  
  def build
  end
end