class StaticPagesController < ApplicationController
  def home
    @messages1 = Message.offset(rand(Message.count) ).limit(3)
    @messages2 = Message.offset(rand(Message.count) ).limit(3)
  end
end
