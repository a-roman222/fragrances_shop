require "test_helper"

class FragrancesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get fragrances_index_url
    assert_response :success
  end

  test "should get show" do
    get fragrances_show_url
    assert_response :success
  end
end
