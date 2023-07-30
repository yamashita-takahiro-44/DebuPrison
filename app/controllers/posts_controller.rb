class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  
  
  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).per(15)
  end  

  def show
    @post = Post.find(params[:id])
    
    image_source = if @post.image.present? && @post.image.url.present?
                     view_context.image_url(@post.image.url)
                   else
                     view_context.image_url('default-avatar.png')  # デフォルトのアバターのパスを指定
                   end
  
    set_meta_tags og: { image: image_source }, twitter: { image: image_source }
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :image, :title)
  end
end
