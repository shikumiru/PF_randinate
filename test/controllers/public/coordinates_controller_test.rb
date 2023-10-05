require "test_helper"

class Public::CoordinatesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_coordinates_new_url
    assert_response :success
  end

  test "should get index" do
    get public_coordinates_index_url
    assert_response :success
  end

  test "should get show" do
    get public_coordinates_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_coordinates_edit_url
    assert_response :success
  end
end
