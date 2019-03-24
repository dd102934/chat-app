class StaticPagesController < ApplicationController
  def home
    @messages1 = Message.order("RANDOM()").limit(3)
    @messages2 = Message.order("RANDOM()").limit(3)
  end
end
