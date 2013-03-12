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

require 'spec_helper'

describe Question do
  before do
    @question = Question.new(qn: "What is your name?", 
	              correct: "Paul", option1: "Jane", option2: "Jeff", option3: "John")
  end
  
  subject { @question }
  
  it { should have_fields(:qn, :correct, :option1, :option2, :option3) }
  
end
