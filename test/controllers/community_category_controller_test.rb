require 'test_helper'

class CommunityCategoryControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get community_category_create_url
    assert_response :success
  end

  test "should get destroy" do
    get community_category_destroy_url
    assert_response :success
  end

end
