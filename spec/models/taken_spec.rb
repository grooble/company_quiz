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

require 'spec_helper'

describe Taken do
  let(:quiz) { FactoryGirl.create(:question) }
  let(:taker) { FactoryGirl.create(:user) }
  
  before do
    @taken = Taken.new(user_id: taker.id, question_id: quiz.id, correct: :true)
  end
  
  #let(:taken) { taker.takens.build(question_id: quiz.id) }
  
  subject{ @taken }
  
  describe "taken methods" do
    it { should be_valid }
    it { should respond_to (:correct) }
    it { should respond_to (:user_id) }
    it { should respond_to (:question_id) }
    it { should respond_to (:correct) }
	its (:question) { should == quiz }
	its (:user) { should == taker }
  end
end
