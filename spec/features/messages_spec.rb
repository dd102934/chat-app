require 'rails_helper'

RSpec.feature "Messages", type: :feature do
  let(:user) { FactoryBot.create(:user,admin: true) }
  
  scenario "A user create a new meesage" do
    sign_in_as user
    fill_in(:message[body], with: "Message")
    click_button
    expect(page).to have_content "Message"
  end
  
  scenario "A user chat and clicks link(username) in chatroom" do
    sign_in_as user
    fill_in(:message[body], with: "Message")
    click_button
    click_link "tester"
  end  
  
end

