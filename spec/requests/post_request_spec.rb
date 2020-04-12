require 'swagger_helper'

# Documentation of the API, used to generate the OpenAPI json
# file at swagger/v1/swagger.json

RSpec.describe 'Blog API', type: :request, swagger_doc: 'v1/swagger.json' do

  path '/posts' do
    post 'Creates a post' do
      tags 'Posts'
      description 'Creates a new post'
      operationId 'createPost'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :post, in: :body, schema: { '$ref' => '#/definitions/post' }

      let(:post) { { title: 'foo', content: 'bar' } }

      response '201', 'Post created' do
        schema '$ref' => '#/definitions/post'
        # run_test!
      end

      response '422', 'Invalid request' do
        schema '$ref' => '#/definitions/errors_object'

        let(:post) { { title: 'foo' } }
        # run_test! do |response|
        #   expect(response.body).to include("can't be blank")
        # end
      end
    end

    get 'Searches posts' do
      tags 'Posts'
      description 'Searches posts by keywords'
      operationId 'searchPosts'
      produces 'application/json'

      response '200', 'Success' do
        schema type: 'array', items: { '$ref' => '#/definitions/post' }
      end

      response '406', 'Unsupported Accept Header' do
        let(:'Accept') { 'application/foo' }
        # run_test!
      end
    end
  end

  path '/posts/{id}' do
    parameter name: :id, in: :path, type: :string

    let(:id) { post.id }
    # let(:post) { Post.create(title: 'foo', content: 'bar', thumbnail: 'thumbnail.png') }

    get 'Retrieves a post' do
      tags 'Posts'
      description 'Retrieves a specific post by id'
      operationId 'getPost'
      produces 'application/json'

      response '200', 'post found' do
        # header 'ETag', type: :string
        # header 'Last-Modified', type: :string
        # header 'Cache-Control', type: :string

        schema '$ref' => '#/definitions/post'

        examples 'application/json' => {
          id: 1,
          title: 'Hello world!',
          content: 'Hello world and hello universe. Thank you all very much!!!',
          thumbnail: 'thumbnail.png'
        }

        let(:id) { post.id }
        # run_test!
      end

      response '404', 'Post not found' do
        let(:id) { 'invalid' }
        # run_test!
      end
    end

    put 'Updates a post' do
      tags 'Posts'
      description 'Updates a specific post by id'
      operationId 'updatePost'
      consumes 'application/json'
      parameter name: :post, :in => :body, schema: {
        type: 'object',
        properties: {
          title: { type: 'string' },
          content: { type: 'string' }
        },
        required: [ 'title', 'content' ]
      }

      response '200', 'Post updated' do
        schema '$ref' => '#/definitions/post'
        # run_test!
      end

      response '404', 'Post not found' do
        let(:id) { 'invalid' }
        # run_test!
      end
    end

    delete 'Deletes a post' do
      tags 'Posts'
      description 'Deletes a specific post by id'
      operationId 'deletePost'
      produces 'application/json'

      response '204', 'Post deleted' do

        # schema '$ref' => '#/definitions/post'

        let(:id) { post.id }
        # run_test!
      end

      response '404', 'Post not found' do
        let(:id) { 'invalid' }
        # run_test!
      end
    end
  end

  path '/posts/{id}/upload' do
    parameter name: :id, in: :path, type: :string

    let(:id) { post.id }
    let(:post) { Post.create(title: 'foo', content: 'bar') }

    put 'Uploads a post thumbnail' do
      tags 'Posts'
      description 'Upload a thumbnail for specific post by id'
      operationId 'uploadThumbnailPost'
      consumes 'image/png'
      parameter name: :thumbnail, :in => :body, :type => :string, :format => :binary, required: true

      response '200', 'post updated' do
        let(:thumbnail) { Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/thumbnail.png")) }
        # run_test!
      end
    end
  end

  path '/comments' do
    post 'Creates a comment' do
      tags 'Comments'
      description 'Creates a new comment from provided data'
      operationId 'createComment'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :comment, in: :body, schema: { '$ref' => '#/definitions/post' }

      let(:comment) { { title: 'foo', content: 'bar' } }

      response '201', 'post created' do
        schema '$ref' => '#/definitions/comment'
        # run_test!
      end

      response '422', 'invalid request' do
        schema '$ref' => '#/definitions/errors_object'

        let(:comment) { { body: 'foo' } }
        # run_test! do |response|
        #   expect(response.body).to include("can't be blank")
        # end
      end
    end

    get 'Returns all comments' do
      tags 'Comments'
      description 'Returns all comments'
      operationId 'getComments'
      produces 'application/json'

      response '200', 'success' do
        schema type: 'array', items: { '$ref' => '#/definitions/comment' }
      end

      response '406', 'Unsupported Accept Header' do
        let(:'Accept') { 'application/foo' }
        # run_test!
      end
    end
  end

  path '/comments/{id}' do
    parameter name: :id, in: :path, type: :string

    let(:id) { post.id }
    let(:comment) { Comment.create(title: 'foo', content: 'bar', thumbnail: 'thumbnail.png') }

    get 'Retrieves a comment' do
      tags 'Comments'
      description 'Retrieves a specific post by id'
      operationId 'getComment'
      produces 'application/json'

      response '200', 'comment found' do

        schema '$ref' => '#/definitions/comment'

        examples 'application/json' => {
          post_id: 1,
          body: 'Hello world and hello universe. Thank you all very much!!!',
        }

        let(:id) { post.id }
        # run_test!
      end

      response '404', 'Comment not found' do
        let(:id) { 'invalid' }
        # run_test!
      end
    end

    put 'Updates a comment' do
      tags 'Comments'
      description 'Updates a specific comment by id'
      operationId 'updateComment'
      consumes 'application/json'
      parameter name: :comment, :in => :body, schema: {
        type: 'object',
        properties: {
          body: { type: 'string' },
        },
        required: [ 'body' ]
      }

      response '200', 'Comment updated' do
        schema '$ref' => '#/definitions/comment'
        # run_test!
      end

      response '404', 'Comment not found' do
        let(:id) { 'invalid' }
        # run_test!
      end
    end

    delete 'Deletes a comment' do
      tags 'Comments'
      description 'Deletes a specific comment by id'
      operationId 'deleteComment'
      produces 'application/json'

      response '204', 'Comment deleted' do

        # schema '$ref' => '#/definitions/post'

        examples 'application/json' => {
          body: 'Hello world and hello universe. Thank you all very much!!!',
          post_id: 1
        }

        let(:id) { post.id }
        # run_test!
      end

      response '404', 'Comment not found' do
        let(:id) { 'invalid' }
        # run_test!
      end
    end
  end

  path '/comments/post/{id}' do
    parameter name: :id, in: :path, type: :string

    let(:id) { post.id }
    let(:comment) { Comment.create(title: 'foo', content: 'bar', thumbnail: 'thumbnail.png') }

    get 'Retrieves the comments by post' do
      tags 'Comments'
      description 'Retrieves the comments of a specific post by id'
      operationId 'show_by_post'
      produces 'application/json'

      response '200', 'Comments found' do
        schema '$ref' => '#/definitions/comment'

        # examples 'application/json' => {
        #   id: 1,
        #   title: 'Hello world!',
        #   content: 'Hello world and hello universe. Thank you all very much!!!',
        #   thumbnail: 'thumbnail.png'
        # }

        # run_test!
      end

      # response '404', 'Comment not found' do
      #   let(:id) { 'invalid' }
      #   run_test!
      # end
    end
  end

  path '/triangles/{a}/{b}/{c}' do

    parameter name: :a, in: :path, type: :string
    parameter name: :b, in: :path, type: :string
    parameter name: :c, in: :path, type: :stringF

    get 'Determinates type of triangle' do
      tags 'Triangles'
      description 'Determinates what type of triangle it is'
      operationId 'determineType'
      produces 'application/json'

      response '200', 'Triangle Type Found' do

        examples 'application/json' => {
            result: 'Scalene / Equilateral / Isosceles / Incorrect'
        }
          # run_test!
      end
    end
  end

end