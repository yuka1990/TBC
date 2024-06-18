class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    if params[:keyword].present?
      @groups = Group.where('groups.name LIKE :keyword OR groups.introduction LIKE :keyword', keyword: "%#{params[:keyword]}%")
    else
    @groups = Group.all
    end
  end
  
  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to admin_groups_path
  end
      
  
end
