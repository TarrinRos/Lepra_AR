require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require 'sinatra/activerecord'

set :database, 'sqlite3:leprosorium.db'

class Post < ActiveRecord::Base
  validates :author, presence: true, length: { minimum: 3 }
  validates :content, presence: true
end

class Comment < ActiveRecord::Base
  validates :author, presence: true, length: { minimum: 3 }
  validates :content, presence: true
  validates :post_id, presence: true
end

get '/' do
  # posts list from DataBase
  @posts = Post.order 'created_at DESC'
  erb :index
end

get '/new' do
  erb :new
end

post '/new' do
  @post = Post.new params[:post]
  if @post.save
    erb 'Thanks for your post'
  else
    @error = @post.errors.full_messages.first
    erb :new
  end
end

get '/details/:id' do
  # @post = Post.find(params[:id])
  erb :details
end

post '/details/:id' do
  @comment = Comment.new params[:comment]
  if @comment.save
    erb 'Thanks for your comment'
  else
    @error = @comment.errors.full_messages.first
    erb :details
  end
end
