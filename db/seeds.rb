# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
posts = Post.create([{title: 'Title Post 1', content: 'This is a blog post.'},
                     {title: 'Title Post 2', content: 'This is a blog post text.'},
                     {title: 'Title Post 3', content: 'This is the content of the Post 3.'}])

comments = Comment.create([{body: 'Comment for Post 1', post_id: 1},
                           {body: 'Comment for Post 2', post_id: 2},
                           {body: 'This is a comment for Post 2', post_id: 2},
                           {body: 'Comment for Post 3', post_id: 3},
                           {body: 'Another comment for Post 3', post_id: 3},
                           {body: 'And yet another for Post 3', post_id: 3}])