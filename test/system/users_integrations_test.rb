require "application_system_test_case"

class UsersIntegrationsTest < ApplicationSystemTestCase
  setup do
    @users_integration = users_integrations(:one)
  end

  test "visiting the index" do
    visit users_integrations_url
    assert_selector "h1", text: "Users Integrations"
  end

  test "creating a Users integration" do
    visit users_integrations_url
    click_on "New Users Integration"

    fill_in "Id", with: @users_integration.id
    fill_in "Integration", with: @users_integration.integration_id
    fill_in "Name", with: @users_integration.name
    fill_in "Options", with: @users_integration.options
    fill_in "Password", with: @users_integration.password
    fill_in "Uri", with: @users_integration.uri
    fill_in "User", with: @users_integration.user_id
    fill_in "Username", with: @users_integration.username
    click_on "Create Users integration"

    assert_text "Users integration was successfully created"
    click_on "Back"
  end

  test "updating a Users integration" do
    visit users_integrations_url
    click_on "Edit", match: :first

    fill_in "Id", with: @users_integration.id
    fill_in "Integration", with: @users_integration.integration_id
    fill_in "Name", with: @users_integration.name
    fill_in "Options", with: @users_integration.options
    fill_in "Password", with: @users_integration.password
    fill_in "Uri", with: @users_integration.uri
    fill_in "User", with: @users_integration.user_id
    fill_in "Username", with: @users_integration.username
    click_on "Update Users integration"

    assert_text "Users integration was successfully updated"
    click_on "Back"
  end

  test "destroying a Users integration" do
    visit users_integrations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Users integration was successfully destroyed"
  end
end
