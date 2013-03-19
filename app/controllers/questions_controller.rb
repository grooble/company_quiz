class QuestionsController < ApplicationController
  before_filter :signed_in_user

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
	current_user.mark(@question,@right_answer)
  end
end
