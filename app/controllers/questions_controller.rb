class QuestionsController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :show, :destroy, :new, :create]

  before_action :professor_user, only: [:edit, :update, :new, :create, :destroy]

  def index
     @questions = Question.paginate(page: params[:page]).order('id')
  end

  def show
  @question = Question.find(params[:id])
  end

  def new
  @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
        flash[:success] = "Question created correctly!"
        redirect_to @question
    else
        render 'new'
    end
  end

  def edit
  end

  def update
  if @question.update_attributes(question_params)
      flash[:success] = "Question updated"
      redirect_to @question
    else
      render 'edit'
    end
  end

  def destroy
    Question.find(params[:id]).destroy
    flash[:success] = "Question deleted"
    redirect_to questions_url
  end

private

    def user_params
        params.require(:question).permit(:text, :ans1, :ans2, :ams3, :ans4, :ans_ok)
    end

    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = "Please log in."
            redirect_to login_url
        end
    end




    # Confirms an professor user.
    def professor_user
        unless this_is_professore?(current_user)
            flash[:danger] = "You don't have the rights for this action."
            redirect_to(root_url)
        end
    end

end
