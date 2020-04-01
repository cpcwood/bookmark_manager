require 'sinatra/base'
require_relative './lib/bookmarks'

class BookmarkManager < Sinatra::Base
  # Environment
  # --------------------

  # Allow html forms to provide put requests
  use Rack::MethodOverride

  # Routes
  # --------------------

  get '/' do
    erb :homepage
  end

  get '/bookmarks' do
    @message = params[:message].gsub('_', ' ') if params[:message]
    @bookmarks = Bookmark.all
    erb :list_bookmarks
  end

  post '/bookmarks' do
    message = Bookmark.add(params[:url], params[:title])
    redirect("/bookmarks?message=#{message}")
  end

  delete '/bookmarks/:id' do
    message = Bookmark.delete(params[:id])
    redirect("/bookmarks?message=#{message}")
  end

  put '/bookmarks/:id' do
    message = Bookmark.update(params[:id], params[:url], params[:title])
    redirect("/bookmarks?message=#{message}")
  end

  #--------------------

  run! if __FILE__ == $0
end
