class SessionController < ApplicationController

    def new

    end

    def create
      chef = Chef.find_by(email: params[:session][:email].downcase)
        if chef && chef.authenticate(params[:session][:password])
          session[:chef_id] = chef.id
          flash[:success] = "Successfully loged in!"
            redirect_to chef
        else
          flash.now[:danger] = "Does not match username or password"
          render 'new'
        end
    end

    def destroy
    session[:chef_id]= nil
    flash[:success] = "Successfully loged out"
    redirect_to root_path
    end
end
