require 'bookmarks'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      expect(Bookmark.all).to include(a_kind_of(Bookmark))
    end
    # it 'rescues error' do
    #   allow(con).to receive(:exec).and_raise('Error')
    #
    #   expect(STDOUT).to receive(:puts).with('Error')
    #   Bookmark.all
    # end
  end
end
