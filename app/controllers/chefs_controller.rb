class ChefsController < ApplicationController

  before_action :sets_chefs, only:[:show, :edit, :update, :destroy]
  before_action :require_same_user, only:[:edit, :update, :destroy]
  before_action :require_admin, only:[:destroy]
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
        redirect_to chefs_path

      end
    end

    def destroy()
      if !@chef.admin?
      @chef.destroy
      flash[:success] = "Chef has been deleted!"
      redirect_to chef_path
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
      if current_chef != @chef && !current_chef.admin?
        flash[:danger] = "you can only edit or delete your won account"
        redirect_to chefs_path
      end
    end

    def require_admin
      if logged_in? && !current_chef.admin?
        flash[:danger] = "you can only edit or delete your won account"
        redirect_to root_path
      end
    end

end