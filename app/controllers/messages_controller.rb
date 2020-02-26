class MessagesController < ApplicationController
protect_from_forgery :except => [:create]
before_action :require_user
  def create
    @message = Message.new(mesages_params)
    @message.chef = current_chef
    if @message.save
      ActionCable.server.broadcast 'chatrooms_channel', message: render_message(@message),
                                                        chef: @message.chef.chefname
    #  redirect_to chat_path
    else
      render 'chatrooms/show'
    end
  end

  private
   def mesages_params
     params.require(:message).permit(:content )
   end



   def render_message(message)
    #render(partial: 'message', locals: { message: message } )
    #render @message
    redirect_to chat_path
  end
end
