require 'pg'

class Bookmarks

  def self.bookmarks_list
    begin
      con = PG.connect :dbname => 'bookmark_manager', :user => ENV['USER']
      rs = con.exec "SELECT * FROM bookmarks"
      list = []
      rs.each{|row| list << row['url']}
    rescue PG::Error => e
      puts e.message
    ensure
      rs.clear if rs
      con.close if con
    end
    list.each_with_index.map{|url, index| "#{index + 1}. #{url}<br>"}.join
  end
end

# .map{|url| {:url => url}}
