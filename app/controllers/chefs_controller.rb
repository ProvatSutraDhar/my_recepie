class ChefsController < ApplicationController

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
      @chef =Chef.find(params[:id])
    end

    def edit
      @chef = Chef.find(params[:id])
    end
    def update
      @chef = Chef.find(params[:id])
      if @chef.update(chef_params)
        flash[:success] = "Chef has been updated!"
        redirect_to chefs_path

      end
    end

    private
    def chef_params
      params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
    end
end
