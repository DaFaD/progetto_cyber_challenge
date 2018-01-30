class QuizzesController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :show, :destroy]
  before_action :professor_user, only: [:edit, :update, :destroy]
  def index
    @quizzes = Quiz.paginate(page: params[:page]).order('id')
  end

  def show
    @quiz = Quiz.find(params[:id])
  end

  def new
    @quiz = Quiz.new
  end

  def create
   @quiz = Quiz.new(quiz_params)
    if @quiz.save

    else
        render 'new'
    end
  end

  def edit
  end

  def update
    if @quiz.update_attributes(quiz_params)
      flash[:success] = "Quiz updated"
      redirect_to @quiz
    else
      render 'edit'
    end
  end

  def destroy
    Quiz.find(params[:id]).destroy
    flash[:success] = "Quiz deleted"
    redirect_to quizzes_url
  end

   private

    def quiz_params
        params.require(:quiz).permit(:q1, :q2,:q3,:q4,:q5,:q6,:q7,:q8,:q9,:q10)
    end

     # Confirms a logged-in user.
    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = "Please log in."
            redirect_to login_url
        end
    end

    # Confirms an admin user.
    def professor_user
        unless this_is_professore?(current_user)
            flash[:danger] = "You don't have the rights for this page."
            redirect_to(root_url)
        end
    end
end
