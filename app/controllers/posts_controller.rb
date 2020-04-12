class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /posts
  def index
    @posts = Post.all

    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # Put /posts/1
  def upload
    @post = Post.find_by_id(params[:id])
    return head :not_found if @post.nil?
    @post.thumbnail = save_uploaded_image params[:file]
    head @post.save ? :ok : :unprocessible_entity
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :content, :thumbnail)
    end

    def save_uploaded_image(field)
      return if field.nil?
      file = File.join('public/uploads', field.original_filename)
      FileUtils.cp field.tempfile.path, file
      field.original_filename
    end
end