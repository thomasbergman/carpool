require 'spec_helper'

describe "User pages" do

	subject { page }

  describe "profile page" do
  	let(:user) { FactoryGirl.create(:user) }
  	before { visit user_path(user) }
  
    it { should have_content(user.first_name) }
    it { should have_title(user.first_name) }
	end

	describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
    	it "should not create a user" do
    		expect {click_button submit }.not_to change(User, :count)
    	end
    end

    describe "with valid information" do
    	before do
    		fill_in "Email", with: "jan@banan.se"
    		fill_in "First name", with: "Jan"
    		fill_in "Last name", with: "Banan"
    		fill_in "Password", with: "123456"
    		fill_in "Confirmation", with: "123456"
    	end

    	it "should create a user" do
    		expect { click_button submit }.to change(User, :count).by(1)
    	end

	    describe "after saving the user" do
	    	before { click_button submit }
	    	let(:user) { User.find_by(email: "jan@banan.se") }

	    	it { should have_title(user.first_name) }
	    end
	  end
	end
end