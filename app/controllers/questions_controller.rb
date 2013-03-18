class QuestionsController < ApplicationController

  def show
    @question = Question.find(params[:id])
	#@option_value = question.try(params[:option])
  end
  
  def ask
  
  end
  
  def answer
    @question = Question.find(params[:id])
    @option_value = @question.try(params[:option])
	@right_answer = false
	if params[:option] == "correct"
	  @right_answer = true
	end
  end
end
