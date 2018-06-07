require 'test_helper'

class ArtistsControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get artists_top_url
    assert_response :success
  end

  test "should get show" do
    get artists_show_url
    assert_response :success
  end

end
