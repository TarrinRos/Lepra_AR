# encoding: utf-8

require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require "sqlite3"
require "sinatra/activerecord"

set :database, 'sqlite3.leprosorium.db'

class Post < ActiveRecord::Base
end
class Comment < ActiveRecord::Base
end

get '/' do
  # posts list from DataBase
  @results = @db.execute 'select * from Posts order by id desc'
  erb :index
end

get '/new' do
  erb :new
end

post '/new' do
  @author_name = params[:author_name]
  @content = params[:content]
  if @content.empty?
    @error = 'Type your text please'
    return erb :new
  end
  # saving data to database
  @db.execute 'insert into Posts (author_name, content, created_date) values (?, ?, datetime())', [@author_name, @content]
  # redirect to main page
  redirect to '/'
  erb "You typed #{@content}"
end

# Returns posts by Id
get '/details/:post_id' do
  # get variables from url
  post_id = params[:post_id]
  # get only one post from db
  results = @db.execute 'select * from Posts where id =?', [post_id]
  @row = results[0]
  # choosing comments for post
  @comments = @db.execute 'select * from Comments where post_id =? order by
   created_date desc', [post_id]
  erb :details
end

post '/details/:post_id' do
  post_id = params[:post_id]
  @content = params[:content]

  @db.execute 'insert into Comments (
              content,
              created_date,
              post_id
)
              values (
              ?,
              datetime(),
              ?
)', [@content, post_id]
  redirect to('/details/' + post_id)
  erb "You typed comment #{@content} with #{post_id}"
end
