class PostsController < ApplicationController
  #caches_action :show

# We don't want anybody anonymous to create new Posts.
# So in all child controllers this filter will work fine. 
  before_filter :check_for_abilities_to_create, :only => [:new, :create]

  def show
    @post = Post.find_by_permalink(params[:id], :include => :comments)
    @comment = Comment.new
    @comment.post = @post
  end

  def show_by_id
    @post = Post.find(params[:id])
    if @post
      redirect_to post_path(@post.permalink)
    end
  end

  def edit
    @post = Post.find(params[:id])
    unauthorized! if cannot? :edit, @post

    @selectable_categories = Category.all.collect{ |c| [c.title, c.id] }
  end

  def increase_rating
    unauthorized! if cannot? :change_rating_for, Post
    Post.increment_counter(:rating, params[:id] )
    @post = Post.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def decrease_rating
    unauthorized! if cannot? :change_rating_for, Post
    Post.decrement_counter(:rating, params[:id] )
    @post = Post.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  private
  def check_for_abilities_to_create
    unauthorized! if cannot? :create, Post
  end
end
