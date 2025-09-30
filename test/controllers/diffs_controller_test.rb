require "test_helper"

class DiffsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get diffs_show_url
    assert_response :success
  end

  test "should get resolve" do
    get diffs_resolve_url
    assert_response :success
  end
end
