class Admin::ChatsController < ApplicationController
   before_action :authenticate_admin!
   
   
  
  def index
    @group = Group.find(params[:group_id])
    @chats = @group.chats
  end
  
  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    redirect_to request.referer
  end
  
end
