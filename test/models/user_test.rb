# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'check password' do
    user = User.create(username: 'user', password: 'password')
    assert user.check_password('password')
  end

  test 'get username' do
    user = User.create(username: 'user')
    assert user.username == 'user'
  end
end
