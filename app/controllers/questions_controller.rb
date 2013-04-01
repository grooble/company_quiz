class QuestionsController < ApplicationController
  before_filter :signed_in_user

  def show
    @question = Question.find(params[:id])
	#@option_value = question.try(params[:option])
  end
    
	# select a random question from the database and display in 
	# show.html.erb
  def ask
    max_id = Question.maximum("id")
	min_id = Question.minimum("id")
	id_range = max_id - min_id
	random_id = min_id + rand(id_range).to_i
	found = Question.where("id >= #{random_id}").first
	@question = Question.find(found)
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
