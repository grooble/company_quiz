require 'spec_helper'

describe Taken do
  let(:quiz) { question_path(1) }
  let(:taker) { FactoryGirl.create(:user) }
  let(:taken) { taker.takens.build(question_id: quiz.id) }
  
  subject{ taken }
  
  it { should be_valid }
end
