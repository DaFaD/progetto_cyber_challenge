class AdvicesController < ApplicationController
    before_action :logged_in_user, only: [:index, :new, :create, :edit, :update, :destroy]
    before_action :professore_user, only: [:index, :new, :create, :edit, :update, :destroy]
    before_action :correct_user_for_this_advice, only: [:edit, :update, :destroy]

    def index
        @advices = Advice.paginate(page: params[:page]).order('id DESC')
    end
    
    def show
        @advice = Advice.find(params[:id])
    end
    
    def new
        @advice = Advice.new
    end
    
    def create
        @advice = Advice.new(advice_params)
        @advice.author= current_user.username
        @advice.writtenAt= Time.now
        if @advice.save
            flash[:success] = "New advice created!"
            redirect_to advices_url
        else
            render 'new'
        end
    end
    
    def edit
    end
    
    def update
        if @advice.update_attributes(advice_params)
            flash[:success] = "Advice updated"
            redirect_to @advice
        else
            render 'edit'
        end
    end
    
    def destroy
        Advice.find(params[:id]).destroy
        flash[:success] = "Advice deleted"
        redirect_to advices_url
    end
    
    private
    
        def advice_params
            params.require(:advice).permit(:title, :content, :author, :writtenAt)
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
        
        # Confirms a professor user.
        def professore_user
            unless this_is_professore?(current_user)
                flash[:danger] = "You don't have the rights for this page/action."
                redirect_to(root_url)
            end
        end
        
        # Confirms the correct user.
        def correct_user_for_this_advice
            @advice = Advice.find(params[:id])
            unless current_user.username==@advice.author
                flash[:danger] = "You don't have the rights for this page/action."
                redirect_to(root_url)
            end
        end
end
