class Admin::CommentsController < ApplicationController
  #before_action :authenticate_admin!
  before_action :ensure_comment, only: [:show, :destroy]

  def index
    @comments = Comment.all
  end

  def show
  end

  def destroy
    @comment.destroy
    redirect_to admin_comments_path
  end

  private
  
  def ensure_comment
    @comment = Comment.find(params[:id])
  end


end
