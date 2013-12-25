require 'spec_helper'

describe "Static pages" do

  subject { page }
  
  describe "Home page" do
    before { visit root_path }
    it { should have_content('Carpool') }

    it "should have the base title" do
  		expect(page).to have_title("Carpool")
		end

    it "should have a custom page title" do
  		expect(page).to have_title("| Home")
		end
  end


  describe "Help page" do
    before { visit help_path }
  	it "should have the content 'Help'" do
  		expect(page).to have_content('Help')
  	end

  	it "should have the right title" do
  		expect(page).to have_title("Carpool | Help")
		end
  end


  describe "About page" do
    before { visit about_path }
  	it "should have the content 'About'" do
  		expect(page).to have_content('About')
  	end

  	it "should have the right title" do
  		expect(page).to have_title("Carpool | About")
		end
  end
end