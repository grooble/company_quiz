class UsersController < ApplicationController
  before_filter :signed_in_user, 
                 only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  
  def show
    @user = User.find(params[:id])
	@microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
	if @user.save
	  sign_in @user
	  flash[:success] = "Welcome to the Yanmar Quiz!"
	  redirect_to @user
	else
	  render 'new'
	end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(params[:user])
	  flash[:success] = "Profile updated"
	  sign_in @user
	  redirect_to @user
	else
      render 'edit'
	end
  end

  def index
    @users = User.paginate(page: params[:page])
  end
  
  def following
=begin
    require 'will_paginate/array'
    @title = "Following"
	@user = User.find(params[:id])
	@cutoff = @user.question_ids.count
	@users = @user.sort_following_by_taken.paginate(page: params[:page])
	@users_under = @users.dup
	@users_over = Array.new
	while ((!@users_under.first.nil?) && (@users_under.first.question_ids.count > @cutoff))
	  #temp_user = @users_under.shift
	  @users_over.unshift(@users_under.shift)
	end
	render 'show_follow'
=end
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def followers
=begin
    require 'will_paginate/array'
    @title = "Followers"
	@user = User.find(params[:id])
	@cutoff = @user.question_ids.count
	@users = @user.sort_follower_by_taken.paginate(page: params[:page])
	@users_under = @users.dup
	@users_over = Array.new
	while ((!@users_under.first.nil?) && (@users_under.first.question_ids.count > @cutoff))
	  #temp_user = @users_under.shift
	  @users_over.unshift(@users_under.shift)
	end
	render 'show_follow'
=end
	@title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private
  	
	def correct_user
	  @user = User.find(params[:id])
	  redirect_to(root_path) unless current_user?(@user)
	end
	
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
