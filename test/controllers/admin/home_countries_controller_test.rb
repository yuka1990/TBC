require "test_helper"

class Admin::HomeCountriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_home_countries_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_home_countries_edit_url
    assert_response :success
  end
end
