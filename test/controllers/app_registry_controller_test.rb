require 'test_helper'

class AppRegistryControllerTest < ActionDispatch::IntegrationTest
  test "should get register" do
    get app_registry_register_url
    assert_response :success
  end

  test "should get de_register" do
    get app_registry_de_register_url
    assert_response :success
  end

  test "should get listen_heart_beat" do
    get app_registry_listen_heart_beat_url
    assert_response :success
  end

  test "should get find_all" do
    get app_registry_find_all_url
    assert_response :success
  end

  test "should get find_by_app_id" do
    get app_registry_find_by_app_id_url
    assert_response :success
  end

  test "should get find_by_instance_id" do
    get app_registry_find_by_instance_id_url
    assert_response :success
  end

  test "should get take_out_instance" do
    get app_registry_take_out_instance_url
    assert_response :success
  end

  test "should get put_back_instance" do
    get app_registry_put_back_instance_url
    assert_response :success
  end

  test "should get update_meta_data" do
    get app_registry_update_meta_data_url
    assert_response :success
  end

  test "should get find_by_vip" do
    get app_registry_find_by_vip_url
    assert_response :success
  end

  test "should get find_by_svip" do
    get app_registry_find_by_svip_url
    assert_response :success
  end

end
