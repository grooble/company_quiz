class QuestionsController < ApplicationController

  def show
    @question = Question.find(params[:id])
	@answersarray = [@question.correct, @question.option1, @question.option2, @question.option3].shuffle
  end
  
  def ask
  end
  
  def answer
    
  end
end
