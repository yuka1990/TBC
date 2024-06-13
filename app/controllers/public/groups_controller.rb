class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_group, only: [:edit, :update, :show, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path, notice: "Successfully saved."
    else
      flash[:alert] = "Failed to save."
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path, notice: "Successfully saved."
    else
      flash[:alert] = "Failed to save."
      render :edit
    end
  end

  def index
    @groups = Group.all
  end

  def show
  end

  def edit
  end
  
  def destroy
    @group.destroy
    redirect_to groups_path
  end

  private

  def ensure_group
    @group = Group.find(params[:id])
  end

  def ensure_correct_user
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end

  def group_params
    params.require(:group).permit(:name, :introduction)
  end

end
