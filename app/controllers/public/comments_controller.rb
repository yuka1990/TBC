class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_comment, only: [:edit, :update, :show, :destroy]
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def create
    post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = post.id
    if @comment.save
    else
      flash[:alert] = "Failed to save."
    end
  end


  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
  end

  def show
  end

  def edit
  end
  
  def update
    if @comment.update(comment_params)
      redirect_to post_path(params[:post_id])
    else
      flash[:alert] = "Failed to save."
      render :edit
    end
  end
  
  def destroy
    @comment.destroy
    redirect_to request.referer
  end
  
  
  private
  
  def ensure_comment
    @comment = Comment.find(params[:id])
  end
  
  def is_matching_login_user
    post = Post.find(params[:post_id])
    unless @comment.user_id == current_user.id
      redirect_to post_path(post)
    end
  end
  
  def comment_params
    params.require(:comment).permit(:body)
  end
end
