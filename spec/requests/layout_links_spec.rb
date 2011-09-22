require 'spec_helper'

describe "LayoutLinks" do
  
  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Home" )
  end
  
  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact" )
  end
  
  it "should have a About page at '/about" do
    get '/about'
    response.should have_selector('title', :content => "About" )
  end
  
  it "should have a Help page at '/help" do
    get '/help'
    response.should have_selector('title', :content => "Help" )
  end
  
  it "should have a signup page at '/signup" do
    get '/signup'
    response.should have_selector('title', :content => "Sign up" )
  end
  
  it "should have a signin page at '/signin" do
    get '/signin'
    response.should have_selector('title', :content => "Sign in" )
  end
  
  it "should have the right links on the layout" do
    visit root_path
    response.should have_selector('title', :content => "Home" )
    click_link "About"
    response.should have_selector('title', :content => "About" )
    click_link "Contact"
    response.should have_selector('title', :content => "Contact" )
    click_link "Help"
    response.should have_selector('title', :content => "Help" )
    visit root_path
    click_link "Sign up now!"
    response.should have_selector('title', :content => "Sign up" )
    response.should have_selector('a[href="/"]>img')
  end
  
  describe "when not sign in" do
    
    it "should have a signin link" do
      visit root_path
      response.should have_selector('a', :content => "Sign in",
                                         :href => signin_path)
    end
  end
  
  describe "when sign in" do
    
    before(:each) do
      @user = Factory(:user)
      visit signin_path
      fill_in "email",    :with => @user.email
      fill_in "password", :with => @user.password
      click_button
    end
    
    it "should have a signout link" do
      visit root_path
      response.should have_selector('a', :content => "Sign out",
                                         :href => signout_path)
    end
    
    it "should have a profile link" do
      visit root_path
      response.should have_selector('a', :content => "Profile",
                                         :href => users_path(@user))
    end
    
    it "should have a setting link" do
      visit root_path
      response.should have_selector('a', :content => "Settings",
                                         :href => edit_user_path(@user))
    end
    
    it "should have a users link" do
      visit root_path
      response.should have_selector('a', :content => "Users",
                                         :href => users_path)
    end
  end
end
