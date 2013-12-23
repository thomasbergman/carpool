class User < ActiveRecord::Base

	require 'bcrypt'
		
	attr_accessible :email, :password, :password_confirmation
	
	attr_accessor :password
	before_save :encrypt_password

	validates_presence_of :password, :on => :create
	validates_presence_of :email
	validates_uniqueness_of :email

	def self.authenticate(email, pw)
		user = find_by_email(email)
		if user && user.password_hash == BCrypt::Engine.hash_secret(pw, user.password_salt)
			user
		else
			nil
		end
	end
	
	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end
end