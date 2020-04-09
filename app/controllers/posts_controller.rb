require 'fileutils'

class PostsController < ApplicationController

  # POST /posts
  def create
    @post = Post.create(params.require(:post).permit(:title, :content))
    # respond_with @post
  end

  # Put /posts/1
  def upload
    @post = Post.find_by_id(params[:id])
    return head :not_found if @post.nil?
    @post.thumbnail = save_uploaded_image params[:file]
    head @post.save ? :ok : :unprocsessible_entity
  end

  # GET /posts
  def index
    @posts = Post.all
    # respond_with @posts
  end

  # GET /posts/1
  def show
    @post = Post.find_by_id(params[:id])

    fresh_when(@post)
    return unless stale?(@post)

    respond_with @post, status: :not_found and return unless @post
    respond_with @post
  end

  private

  def save_uploaded_image(field)
    return if field.nil?
    file = File.join('public/uploads', field.original_filename)
    FileUtils.cp field.tempfile.path, file
    field.original_filename
  end
end