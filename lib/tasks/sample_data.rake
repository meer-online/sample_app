require 'faker'
   namespace :db do
	 desc "Fill database with sample data"
	task :populate => :environment do
	  Rake::Task['db:reset'].invoke
	  make_users
	  make_microposts
	  make_relationships
	end
   end
   
   def make_users
	 admin = User.create!(:name => "Muneeb Meer",
						  :email => "abdul.muneeb@nxb.com.pk",
						  :password => "password",
						  :password_confirmation => "password")
	 admin.toggle!(:admin)
	 49.times do |n|
		name = Faker::Name.name
	    email = "example-#{n+1}@railstutorial.org"
		password = "password"
	    User.create!(:name => name,
					 :email => email,
					 :password => password,
					 :password_confirmation => password)
	end
  end
   
  def make_microposts
	User.all(:limit => 6).each do |user|
	  25.times do
		content = Faker::Lorem.sentence(5)
		user.microposts.create!(:content => content)
	  end
    end
  end
  
  def make_relationships
	users = User.all
	user = users.first
	following = users[1..25]
	followers = users[3..20]
	following.each { |followed| user.follow!(followed) }
	followers.each { |follower| follower.follow!(user) }
  end
