# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid' do
    user = User.create(name: 'Example User', email: 'user@example.com', \
                    password: 'password', password_confirmation: 'password')
    assert user.valid?
    user = User.create(name: 'Example User', \
                    password: 'password', password_confirmation: 'password')
    assert_not user.valid?
    user = User.create(name: 'Example User', email: 'user@example.com', \
                      password: 'password', password_confirmation: 'password')
    assert_not user.valid?
  end

  test 'check password' do
    user = User.create(name: 'Example User', email: 'user@example.com', \
                       password: 'password', password_confirmation: 'password')
    assert user.authenticate('password')
    assert_not user.authenticate('not password')
  end

  test 'email valid' do
    user = User.create(name: 'Example User', email: 'userexample.com', \
                      password: 'password', password_confirmation: 'password')
    assert_not user.valid?
  end
end
