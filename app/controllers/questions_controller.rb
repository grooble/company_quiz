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
	  flash[:success] = t('question.created')
	  redirect_to @user
	else
	  flash.now[:error] = t('question.flash_error')
	  render 'new'
    end
  end
  
  def show
    @question = Question.find(params[:id])
  end
    
	# select a random question from the database and display in 
	# show.html.erb
  def ask
    @user = current_user
    languages_string = @user.question_languages
	languages = languages_string.split(",")
	approveds = Question.where(language: [languages])
	found = approveds.first(:order => "RANDOM()")
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
	  flash[:success] = t('question.approve_success')
	  redirect_to :back
	else
	  flash.now[:error] = t('question.approve_error')
	  redirect_to @user
    end	
  end
  
  def destroy
    if Question.find(params[:id]).destroy
     @user = current_user
	 flash[:success] = t('question.delete_success')
     redirect_to :back
    else
      flash.now[:error] = t('queation.delete_failed')
	  redirect_to @user
	end
 end
 
   private
   
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
