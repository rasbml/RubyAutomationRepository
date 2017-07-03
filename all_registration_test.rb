require 'test/unit'
require 'selenium-webdriver'
require_relative 'my_module'

class AllRegistrationTest < Test::Unit::TestCase

  include MyModule

  def setup
    #@driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 30)
    Selenium::WebDriver::Chrome.driver_path='/Users/sergeim/chromedriver'
    @driver = Selenium::WebDriver.for :chrome

  end

  def test_registered_user
    register_user

    expected_text = 'Your account has been activated. You can now log in.'
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)
  end

  def test_logout
    test_registered_user
    logout_user

    login_button = @driver.find_element(:class, 'login')

    assert(login_button.displayed?)

  end

  def test_login
    test_registered_user
    logout_user
    login_user

    logout_button = @driver.find_element(:class, 'logout')

    assert(logout_button.displayed?)

  end

  def test_change_password
    test_registered_user
    change_user_password

    expected_text = 'Password was successfully updated.'
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)

  end

  def test_create_project
    test_registered_user
    logout_user
    login_user
    create_project
    expected_text = 'Successful creation.'
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)
  end

  def test_add_user_to_project
    register_user
    logout_user
    register_additional_user
    create_project
    add_user_to_project
    sleep 5
    expected_text = 'userX'+@login+' userXLastName'
    actual_text = @driver.find_element(:link_text, 'userX'+@login+' userXLastName').text
    assert_equal(expected_text, actual_text)
  end

  def teardown
    @driver.quit
  end
end

