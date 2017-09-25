# encoding: utf-8

require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require "sqlite3"
require "sinatra/activerecord"

set :database, 'sqlite3:leprosorium.db'

class Post < ActiveRecord::Base
end
class Comment < ActiveRecord::Base
end

get '/' do
  # posts list from DataBase
  erb 'Hello'
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
