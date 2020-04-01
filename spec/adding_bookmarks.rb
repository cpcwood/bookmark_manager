feature 'Adding Bookmarks' do
  scenario 'adds bookmark to list' do
    visit '/bookmarks'
    fill_in('url', with: 'http://www.testsite.com')
    fill_in('title', with: 'Test site')
    click_button('Add Bookmark')
    expect(page).to have_link('Test Site', href: 'http://www.testsite.com')
  end
end
