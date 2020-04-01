feature 'Viewing bookmarks' do
  scenario 'shows a list of bookmarks' do
    visit '/bookmarks'
    expect(page).to have_link('Google', href: 'http://www.google.com')
    expect(page).to have_link('Youtube', href: 'http://www.youtube.com')
  end
end
