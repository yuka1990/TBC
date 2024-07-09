class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_comment, only: [:destroy]

  def index
    @search = params[:search]
    @min_max_score = params[:min_score] && params[:max_score]
    @min_score = params[:min_score]
    @max_score = params[:max_score]
    
    @comments = Comment.page(params[:page]).per(20).order(created_at: :desc)
    @comments = @comments.search_by_body(@search) if @search.present?
    @comments = @comments.search_by_min_score(@min_score) if @min_score.present?
    @comments = @comments.search_by_max_score(@max_score) if @max_score.present?
    
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
