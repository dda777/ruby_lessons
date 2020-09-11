require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path,
           params: {
               user: {
                   name: "",
                   email: "user@invalid",
                   password: "foo",
                   password_confirmation: "bar"
               }
           }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
    assert_not flash.any?
  end

  test 'successful send form' do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path,
                        params: {
                            user: {
                                name: 'Денис',
                                email: 'd.dikiy@tavriav.com.ua',
                                password: 'Rhjyjc2910',
                                password_confirmation: 'Rhjyjc2910'
                            }
                        }
      follow_redirect!
    end
    assert_template 'users/show'
  end
end
