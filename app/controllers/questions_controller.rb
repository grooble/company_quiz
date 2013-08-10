class QuestionsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, only: [:destroy, :approve]


  def new
    @question = Question.new
  end
  
  def create
    @question = Question.new(params[:question])
	if @question.save
	  @user = current_user
	  flash[:success] = "Question successfully created!"
	  redirect_to @user
	else
	  flash.now[:error] = 'You have missing question fields'
	  render 'new'
    end
  end
  
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
  
  def pending
    # @pended is a list of unapproved (new) questions 
    @pended = Question.where(approved: false)
  end
  
  def approve
    @pended = Question.find(params[:qid])
	@pended.approved = true
	if @pended.save
	  @user = current_user
	  flash[:success] = 'Question successfully approved!'
	  redirect_to @user
	else
	  flash.now[:error] = 'There was an error updating your question. Try again.'
	  redirect_to @user
    end	
  end
  
  def destroy
    if Question.find(params[:id]).destroy
     @user = current_user
	 flash[:success] = "Question deleted."
     redirect_to :back
    else
      flash.now[:error] = 'Delete failed. Try again.'
	  redirect_to @user
	end
 end
 
   private
   
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
