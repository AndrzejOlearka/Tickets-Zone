require "test_helper"

class UsersIntegrationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @users_integration = users_integrations(:one)
  end

  test "should get index" do
    get users_integrations_url
    assert_response :success
  end

  test "should get new" do
    get new_users_integration_url
    assert_response :success
  end

  test "should create users_integration" do
    assert_difference('UsersIntegration.count') do
      post users_integrations_url, params: { users_integration: { id: @users_integration.id, integration_id: @users_integration.integration_id, name: @users_integration.name, options: @users_integration.options, password: @users_integration.password, uri: @users_integration.uri, user_id: @users_integration.user_id, username: @users_integration.username } }
    end

    assert_redirected_to users_integration_url(UsersIntegration.last)
  end

  test "should show users_integration" do
    get users_integration_url(@users_integration)
    assert_response :success
  end

  test "should get edit" do
    get edit_users_integration_url(@users_integration)
    assert_response :success
  end

  test "should update users_integration" do
    patch users_integration_url(@users_integration), params: { users_integration: { id: @users_integration.id, integration_id: @users_integration.integration_id, name: @users_integration.name, options: @users_integration.options, password: @users_integration.password, uri: @users_integration.uri, user_id: @users_integration.user_id, username: @users_integration.username } }
    assert_redirected_to users_integration_url(@users_integration)
  end

  test "should destroy users_integration" do
    assert_difference('UsersIntegration.count', -1) do
      delete users_integration_url(@users_integration)
    end

    assert_redirected_to users_integrations_url
  end
end
