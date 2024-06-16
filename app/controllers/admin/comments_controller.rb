class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_comment, only: [:destroy]

  def index
    if params[:search].present?
      @comments = Comment.where('body LIKE :search', search: "%#{params[:search]}%")
    else
    @comments = Comment.all
    end
  end

  def show
    @post = Post.find(params[:post_id])
    @comments = @post.comments
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
