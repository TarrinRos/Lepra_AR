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
end

get '/' do
  # posts list from DataBase
  @results = Post.order 'created_at DESC'
  erb :index
end

get '/new' do
  erb :new
end

post '/new' do
  @db = Post.new params[:post]
  if @db.save
    erb 'Thanks for your post'
  else
    @error = @db.errors.full_messages.first
    erb :new
  end
end

get '/details/:id' do
  @comments = Comment.find params[:post_id]
  @row = Post.new params[:post]
  erb :details
end
