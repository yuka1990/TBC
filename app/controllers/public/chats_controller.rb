class Public::ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :block_non_related_users, only: [index]
  before_action :check_guest_user


  def create
    group = Group.find(params[:group_id])
    @chat = current_user.chats.new(chat_params)
    @chat.group_id = group.id
    if @chat.save
      redirect_to request.referer
    else
      flash.now[:alert] = "Failed to save."
      redirect_to request.referer
    end
  end

  def index
    @group = Group.find(params[:group_id])
    @chats = @group.chats
  end


  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    redirect_to request.referer
  end



  private

  def check_guest_user
    if current_user.email == "guest@example.com"
      redirect_to groups_path, alert:"Access is not permitted."
    end
  end

  def block_non_related_users
    unless current_user.groups.include?(params[:group_id])
      redirect_to groups_path, alert: "このグループのメンバーでないため、グループ一覧へ遷移しました。"
    end
  end

  def chat_params
    params.require(:chat).permit(:message, :group_id)
  end

end