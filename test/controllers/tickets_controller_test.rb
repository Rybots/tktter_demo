require 'test_helper'

class TicketsControllerTest < ActionDispatch::IntegrationTest
  test "should get sell" do
    get tickets_sell_url
    assert_response :success
  end

  test "should get show" do
    get tickets_show_url
    assert_response :success
  end

end
