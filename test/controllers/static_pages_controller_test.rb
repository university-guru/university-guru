# frozen_string_literal: true

require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get moderator' do
    get static_pages_moderator_url
    assert_response :success
  end

  test 'should get administrator' do
    get static_pages_administrator_url
    assert_response :success
  end
end
