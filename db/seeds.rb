# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

org = Organisation.create(:name  =>'PeopleFolderTest')

usergroup = UserGroup.create(:name => 'PeopleFolderTest Admin', :group_type => 'admin', :organisation => org)

user = User.new(:email => "test@peoplefolder.com", :password => "lolcated", :organisation => org,
  :first_name => "Jason", :last_name => "Tester", :user_group => usergroup)
user.save!