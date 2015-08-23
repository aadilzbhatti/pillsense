require 'test_helper'

class CareProviderTest < ActiveSupport::TestCase
  def setup
    @care_provider = CareProvider.new(name: 'Example Care Provider', email: 'user@example.com',
                                      password: '123456', password_confirmation: '123456')
  end

  test 'should be valid' do
    assert @care_provider.valid?
  end

  test 'name should be present' do
    @care_provider.name = '      '
    assert_not @care_provider.valid?
  end

  test 'email should be present' do
    @care_provider.email = '      '
    assert_not @care_provider.valid?
  end

  test 'name should not be too long' do
    @care_provider.name = 'a' * 51
    assert_not @care_provider.valid?
  end

  test 'email should not be too long' do
    @care_provider.email = 'a' * 244 + '@example.com'
    assert_not @care_provider.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @care_provider.email = valid_address
      assert @care_provider.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @care_provider.email = invalid_address
      assert_not @care_provider.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'user should be unique' do
    duplicate_user = @care_provider.dup
    @care_provider.save
    assert_not duplicate_user.valid?
  end

  test 'email address should be unique' do
    duplicate_user = @care_provider.dup
    duplicate_user.email = @care_provider.email.upcase
    @care_provider.save
    assert_not duplicate_user.valid?
  end

  test 'password should be present (non-blank)' do
    @care_provider.password = @care_provider.password_confirmation = ' ' * 6
    assert_not @care_provider.valid?
  end

  test 'password should have a minimum length' do
    @care_provider.password = @care_provider.password_confirmation = 'a' * 5
    assert_not @care_provider.valid?
  end

  # test 'authenticated? should return false for a nil digest' do
  #   assert_not @care_provider.authenticated?('')
  # end
end
