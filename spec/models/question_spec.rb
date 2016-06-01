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

require 'spec_helper'

describe Question do

  before do
    @question = Question.new(qn: "What is your name?", 
	              correct: "Paul", option1: "Jane", option2: "Jeff", option3: "John")
  end
  
  subject { @question }
  
  it { should respond_to(:qn) }
  it { should respond_to(:correct) }
  it { should respond_to(:option1) }
  it { should respond_to(:option2) }
  it { should respond_to(:option3) }
  it { should respond_to(:approved) }
  
  describe "when question is not present" do
    before { @question.qn = " " }
	it { should_not be_valid }
  end
  
  describe "when question is too short" do
    before { @question.qn = "a" * 11 }
	it { should_not be_valid }
  end

  describe "when answer is not present" do
    before { @question.correct = " " }
	it { should_not be_valid }
  end

end

describe Question do

  subject { Question }

  it { should respond_to :takens_taken }

end
