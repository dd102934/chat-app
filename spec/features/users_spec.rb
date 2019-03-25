require 'rails_helper'

RSpec.feature "Users", type: :feature do
  
   let(:user) { FactoryBot.create(:user) }
   
   scenario "create a new user" do
     visit root_path
     first(:link, "登録").click
      
     expect {
        fill_in "user[username]", with: "Test_user"
        fill_in "user[password]", with: "test123"
        fill_in "user[password_confirmation]", with: "test123"
        click_button "登録"
      }.to change(User, :count).by(1)

  
     expect(page).to have_content "Test_userさん　チャットアプリの世界にようこそ！"
   end   
     
   scenario "A user successfully login" do
     sign_in_as user
     expect(page).to have_content "マイページ"
     expect(page).to have_content "編集"
     expect(page).to have_content "ログアウト"
     expect(page).to have_content "ログインしました"
   end
   
   scenario "A user successfully logout" do
     sign_in_as user
     click_link "ログアウト"
     visit chatroom_path
     expect(page).to have_content "ログインしてください"
   end 
   
   scenario "successfully edit a user" do
     sign_in_as user
     click_link "編集"
     fill_in "user[username]", with: "Edit"
     fill_in "user[comment]", with: "test"
     fill_in "user[password]", with: "edit"
     fill_in "user[password_confirmation]", with: "edit"
     click_button "変更"
     expect(page).to have_content "アカウントの情報を更新しました"
     expect(page).to have_content "Edit"
     expect(page).to have_content "test"
   end
   
  scenario "A user add message, one more message in showpage  " do
    sign_in_as user
    fill_in(:message[body], with: "Message")
    click_button
    click_link "tester"
    expect(page).to have_content "1 message"
  end  
   
   


end
