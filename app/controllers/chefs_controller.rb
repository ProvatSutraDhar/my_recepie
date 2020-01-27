class ChefsController < ApplicationController

  before_action :sets_chefs, only:[:show, :edit, :update]
  before_action :require_user, except:[:index, :show]
  before_action :require_same_user, only:[:edit, :update, :destroy]

    def index
      @chefs =Chef.all
    end
     def new
       @chef = Chef.new
     end

    def create
      @chef =Chef.new(chef_params)
      if @chef.save
        session[:chef_id]=@chef.id
        flash[:success] = "Welcome #{chef.chefname} to my Recipe App"
        redirect_to chef_path(@chef)
      else
        render 'new'
      end
    end

    def show

    end

    def edit

    end
    def update

      if @chef.update(chef_params)
        flash[:success] = "Chef has been updated!"
        redirect_to chefs_path

      end
    end

    private
    def chef_params
      params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
    end

    def sets_chefs
        @chef = Chef.find(params[:id])
    end

    def require_same_user
      if current_chef != @chef
        flash[:danger] = "you can only edit or delete your won account"
        redirect_to chefs_path
      end
    end
end
