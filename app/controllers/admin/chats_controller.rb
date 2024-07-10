class Admin::ChatsController < ApplicationController
   before_action :authenticate_admin!
  
  def index
    @group = Group.find(params[:group_id])
    @search = params[:search]
    @chats = @group.chats
    @chats = @chats.search_by_message(@search) if @search.present?
  end
  
  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    redirect_to request.referer
  end
  
end
