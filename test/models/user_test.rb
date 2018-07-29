require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Should not save user without username" do
    user = User.new
    user.email= "toan@nguyen.com"
    assert_not user.save
  end

  test "Should not save user without email" do
    user = User.new
    user.username = "toannguyen"
    assert_not user.save
  end

  test "Should not have duplicate email" do
    user = User.new
    user.username = "toannguyen"
    user.email = "toannguyen@email.com"
    user.save

    user2 = User.new
    user2.username = "toannguyen"
    user2.email = "toannguyen@email.com"
    assert_not user.save
  end
end
