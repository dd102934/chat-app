module LoginSupport
  def sign_in_as(user)
    visit root_path
    first(:link, "ログイン").click
    fill_in "session[username]", with: user.username
    fill_in "session[password]", with: user.password
    click_button "ログイン"
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end