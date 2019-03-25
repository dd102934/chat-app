require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is valid with a first name, and password" do
    user = User.new(
      username: "Aaron",
      password:   "dottle-nouveau-pavilion-tights-furze",
    )
    expect(user).to be_valid
  end

  it { is_expected.to validate_presence_of :username }
  it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
  it { should validate_length_of(:username).is_at_least(1).is_at_most(15)}
  it { should validate_length_of(:comment).is_at_most(10) }
end
