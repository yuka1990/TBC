class Public::ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :block_non_related_users, only: [:index]

  def create
    group = Group.find(params[:group_id])
    @chat = current_user.chats.new(chat_params)
    @chat.group_id = group.id
    if @chat.save
      redirect_to request.referer
    else
      flash[:alert] = "Failed to save."
      redirect_to request.referer
    end
  end

  def index
    @group = Group.find(params[:group_id])
    @chats = @group.chats
    @chat = Chat.new
  end

  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    redirect_to request.referer
  end

  private

  def block_non_related_users
    group = Group.find(params[:group_id])
    unless group.owner_id == current_user.id || current_user.groups.exists?(id: group.id)
      redirect_to groups_path, alert: "You have been redirected to the group list because you are not a member of this group."
    end
  end

  def chat_params
    params.require(:chat).permit(:message, :group_id)
  end

end
