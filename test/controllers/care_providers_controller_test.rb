require 'test_helper'

class CareProvidersControllerTest < ActionController::TestCase
  setup do
    @care_provider = care_providers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:care_providers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create care_provider" do
    assert_difference('CareProvider.count') do
      post :create, care_provider: { name: @care_provider.name }
    end

    assert_redirected_to care_provider_path(assigns(:care_provider))
  end

  test "should show care_provider" do
    get :show, id: @care_provider
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @care_provider
    assert_response :success
  end

  test "should update care_provider" do
    patch :update, id: @care_provider, care_provider: { name: @care_provider.name }
    assert_redirected_to care_provider_path(assigns(:care_provider))
  end

  test "should destroy care_provider" do
    assert_difference('CareProvider.count', -1) do
      delete :destroy, id: @care_provider
    end

    assert_redirected_to care_providers_path
  end
end
