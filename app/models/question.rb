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
#  approved   :boolean          default(FALSE)
#  language   :string(255)      default("en")
#

class Question < ActiveRecord::Base

  validates :qn, presence: true, length: { minimum: 12 }
  validates :correct, presence: true
  validates :option1, presence: true
  validates :option2, presence: true
  validates :option3, presence: true
  validates :language, presence: true

  attr_accessible :category, :correct, :option1, :option2, :option3, :qn, :approved, :language
  
  # test the following
  # belongs_to :user


  def self.takens_taken(user)
 	@takens = Taken.select("question_id").where("user_id = :user_id", user_id: user.id)
	ids = @takens.map{ |t| t.question_id }
	@questions = Question.all
    @questions.select!{ |q| ids.include?  q.id }
  end
  
end
