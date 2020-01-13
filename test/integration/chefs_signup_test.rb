require 'test_helper'

class ChefsSignupTest < ActionDispatch::IntegrationTest

    test "should go to signup path" do
      get signup_path
      assert_response :success
    end

end
