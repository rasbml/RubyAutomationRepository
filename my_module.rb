module MyModule
  def register_user
    @driver.navigate.to 'http://demo.redmine.org'
    @driver.find_element(:class, 'register').click

    @wait.until {@driver.find_element(:id, 'user_login').displayed?}

    @login = ('SMlogin' + rand(99999).to_s)
    @password= 'this_is_my_new_userX_pwd'

    @driver.find_element(:id, 'user_login').send_keys @login
    @driver.find_element(:id, 'user_password').send_keys @password
    @driver.find_element(:id, 'user_password_confirmation').send_keys @password
    @driver.find_element(:id, 'user_firstname').send_keys 'userX'+@login
    @driver.find_element(:id, 'user_lastname').send_keys 'userXLastName'
    @driver.find_element(:id, 'user_mail').send_keys (@login + '@trololo.com')

    @driver.find_element(:name, 'commit').click
    sleep 5
  end

  def register_additional_user
    @driver.navigate.to 'http://demo.redmine.org'
    @wait.until {@driver.find_element(:class, 'register').displayed?}
    @driver.find_element(:class, 'register').click

    @wait.until {@driver.find_element(:id, 'user_login').displayed?}

    @login_additional_user = ('SMlogin' + rand(99999).to_s)

    @driver.find_element(:id, 'user_login').send_keys @login_additional_user
    @driver.find_element(:id, 'user_password').send_keys @password
    @driver.find_element(:id, 'user_password_confirmation').send_keys @password
    @driver.find_element(:id, 'user_firstname').send_keys 'userXFirstName'
    @driver.find_element(:id, 'user_lastname').send_keys 'userXLastName'
    @driver.find_element(:id, 'user_mail').send_keys (@login_additional_user + '@trololo.com')

    @driver.find_element(:name, 'commit').click
    sleep 5
  end

  def logout_user
    @driver.find_element(:class, 'logout').click
    sleep 5

  end

  def login_user
    @driver.find_element(:class, 'login').click
    @wait.until {@driver.find_element(:id, 'username').displayed?}
    @driver.find_element(:id, 'username').send_keys @login
    @driver.find_element(:id, 'password').send_keys @password
    @driver.find_element(:name, 'login').click
    sleep 5
  end

  def change_user_password
    @driver.navigate.to 'http://demo.redmine.org/my/password'
    @driver.find_element(:id, 'password').send_keys 'this_is_my_new_userX_pwd'
    @driver.find_element(:id, 'new_password').send_keys 'this_is_my_new_new_userX_pwd'
    @driver.find_element(:id, 'new_password_confirmation').send_keys 'this_is_my_new_new_userX_pwd'
    @driver.find_element(:name, 'commit').click
    sleep 5

  end

  def create_project
    @projectname=('smproject' + rand(99999).to_s)
    @driver.navigate.to 'http://demo.redmine.org/projects/new'
    @wait.until {@driver.find_element(:id, 'project_name').displayed?}
    @driver.find_element(:id, 'project_name').send_keys @projectname
    @driver.find_element(:id, 'project_identifier').send_keys 'smproject'
    @driver.find_element(:name, 'commit').click
    sleep 3

  end

  def add_user_to_project
    @driver.find_element(:xpath, '//*[@id="tab-members"]').click
    @wait.until {@driver.find_element(:xpath, '//*[@id="tab-content-members"]/p/a').displayed?}
    @driver.find_element(:xpath, '//*[@id="tab-content-members"]/p/a').click
    @wait.until {@driver.find_element(:id, 'principal_search').displayed?}
    @driver.find_element(:id, 'principal_search').send_keys 'userX'+@login
    sleep 3
    @driver.find_element(:css, '#principals > label > input[type="checkbox"]').click
    @driver.find_element(:css, '#new_membership > fieldset:nth-child(3) > div > label:nth-child(1) > input[type="checkbox"]').click
    @driver.find_element(:id, 'member-add-submit').click
    sleep 5
  end

end