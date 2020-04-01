require 'pg'

class Bookmark

  # Instance
  # ============================

  attr_reader :title, :url, :id

  def initialize(database_object)
    @title = database_object['title']
    @url = database_object['url']
    @id = database_object['id']
  end

  # Class
  # ============================

  def self.all
    con = self.connect
    begin
      rs = con.exec "SELECT * FROM bookmarks"
      list = []
      rs.each {|row| list << self.new(row)}
    rescue => e
      puts e.message
    ensure
      rs.clear if rs
      con.close if con
    end
    list.sort_by{|bookmark| bookmark.id}
  end

  def self.add(url, title)
    # Check Data
    url = url.strip
    if !self.valid_url?(url)
      message = 'URL_Invalid!'
    elsif title.empty?
      message = 'Title_Empty!'
    else
      # Update data
      begin
        con = self.connect
        con.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}')")
        message = 'Bookmark_added!'
      rescue => e
        puts e.message
        message = e
      ensure
        con.close if con
      end
    end
    message
  end

  def self.update(id, url, title)
    message = 'Bookmark_Updated!'
    # Check Data
    url = url.strip
    url, message = self.retrive_item(id).url, 'URL_Invalid!' unless self.valid_url?(url)
    title, message = self.retrive_item(id).title, 'Bookmark_Updated!_Title_left_empty' if title.empty?

    # Update data
    con = self.connect
    begin
      con.exec("UPDATE bookmarks SET url = '#{url}', title = '#{title}' WHERE id = #{id}")
    rescue => e
      puts e.message
      message = e
    ensure
      con.close if con
    end
    message
  end

  def self.delete(id)
    message = 'Bookmark_Deleted!'
    con = self.connect
    begin
      con.exec("DELETE FROM bookmarks WHERE id = #{id}")
    rescue => e
      puts e.message
      message = e
    ensure
      con.close if con
    end
    message
  end

  def self.custom_command(command)
    con = self.connect
    begin
      con.exec(command)
    rescue => e
      puts e.message
    ensure
      con.close if con
    end
  end

  def self.connect
    database = (ENV['ENVIRONMENT'] == 'test' ? 'bookmark_manager_test' : 'bookmark_manager')
    PG.connect(:dbname => database, :user => ENV['USER'])
  end

  private

  def self.valid_url?(url)
    url.match?(/\Ahttp{1}[s]?:\/\/w{3}\.[\w-]+\.[\w]{2,}\z/)
  end

  def self.retrive_item(id)
    con = self.connect
    begin
      item = con.exec "SELECT * FROM bookmarks WHERE id = #{id}"
    rescue => e
      puts e.message
    ensure
      con.close if con
    end
    self.new(item[0])
  end
end
