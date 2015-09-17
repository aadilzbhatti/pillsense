require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = care_providers(:aadil)
    @non_admin = care_providers(:archer)
  end

  test 'index as non-admin' do
    log_in_as(@non_admin)
    get care_providers_path
    assert_select 'a', text: 'delete', count: 0
  end
end

