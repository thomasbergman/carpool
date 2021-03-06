require 'spec_helper'

describe User do
	before do
		@user = User.new(email: "jan@banan.se", first_name: "Jan",
			last_name: "banan", password: "123456", password_confirmation: "123456")
	end

	subject { @user }

	it { should respond_to(:email) }
	it { should respond_to(:first_name) }
	it { should respond_to(:last_name) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:authenticate) }
	it { should respond_to(:remember_token) }

	it { should be_valid }

	describe "when user not present" do
		before { @user.first_name = " " }
		it { should_not be_valid }
	end

	describe "when first_name is too long" do
		before {@user.first_name = "a" * 51 }
		it { should_not be_valid }
	end

	describe "when email format is invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
			addresses.each do |invalid_addresses|
				@user.email = invalid_addresses
				expect(@user).not_to be_valid
			end
		end
	end

	describe "when email format is valid" do
		it "should be valid" do
			addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			addresses.each do |valid_address|
				@user.email = valid_address
				expect(@user).to be_valid
			end
		end
	end

	describe "when email address is already taken" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end
		it { should_not be_valid }
	end

	describe "when password is not present" do
		before do
			@user = User.new(email: "jan@banan.se", first_name: "Jan", last_name: "banan", password: " ", password_confirmation: " ")
		end
		it { should_not be_valid }		
	end

	describe "when password doesn't match confirmation" do
		before { @user.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end

	describe "return value of authenticate method" do
		before { @user.save }
		let(:found_user) { User.find_by(email: @user.email) }

		describe "with vaild password" do
			it {should eq found_user.authenticate(@user.password) }
		end
	
		describe "with invalid password" do
			let(:user_for_invalid_password) { found_user.authenticate("invalid") }

			it { should_not eq user_for_invalid_password }
			specify { expect(user_for_invalid_password).to be_false }
		end
	end

	describe "remeber token" do
		before { @user.save }
		its(:remember_token) { should_not be_blank }
	end
end