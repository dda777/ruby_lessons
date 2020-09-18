require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test 'unsuccessful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {
        user: {
            name: '',
            email: '',
            password: '',
            password_confirmation: ''
        }}
    assert_template 'users/edit'
  end

  test 'successful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = 'Дикий Денис'
    email = 'denis.dikiy@gmail.com'
    patch user_path(@user), params: {
        user: {
            name: name,
            email: email,
            password: '',
            password_confirmation: ''
        }}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name = 'Дикий Денис'
    email = 'denis.dikiy@gmail.com'
    patch user_path(@user), params: {
        user: {
            name: name,
            email: email,
            password: '',
            password_confirmation: ''
        }}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email
  end

  test 'unsuccessful edit with friendly forwarding' do
    get edit_user_path(@user)
    assert_redirected_to login_path
    get edit_user_path(@user)
    assert_redirected_to user_path
  end
end
