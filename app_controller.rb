require 'sinatra'
require 'bookmarks'

class BookmarkApp < Sinatra::Base
  enable :sessions

  get '/' do

    @list = Bookmarks.bookmarks_list

    erb :homepage 
  end

  run! if $0 == __FILE__
end
