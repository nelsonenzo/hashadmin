## would be cool if there was a little admin database seperate from the 
## project db to store project info - like the name of the gemset, heroku app name, etc.
## maybe it's even a system database that has 'All Projects' info.
## be wary of 'history' - you won't see other committers mods.
## probably best to only save things related to this system or global to the world, like
## heroku project name,etc.
require 'octokit'

get '/rvm/rubies' do
	`rvm list`
	# %x[rvm list] #does the same as above, but uglier! maybe useful if you ever need quotes.
	#downside to both these is that it does not get stderr, just stdout.
end

get '/rvm/set_ruby' do
	ver = 'ruby-1.9.2-p290'
	result = %x[rvm #{ver}]
	# crappy - this won't work.  maybe better luck with rbenv
	result
end

get '/gem/install/:gem' do
	`gem install #{params[:gem]}`
end

get '/gem/bundle/install' do
	`bundle install`
end

get '/git/init' do
	`git init`
end

get '/git/add_all' do
	`git add *`
end

get '/git/commit_1' do
	`git commit -m "first commit"`
end

get '/git/commit/any/:message' do
	#git quick commit of any changes that have been made - this is dangerous.
end

get '/git/github/create' do
	#create the gitub repo
end

post '/git/github/share' do
	#using github api, share to git usernames/email addresses
end

get '/heroku/sign_in' do
	#multi part step, if at all possible, probably need one of the fancier
	#io options.  check out http://tech.natemurray.com/2007/03/ruby-shell-commands.html
end

get '/heroku/create' do
	`heroku create`
end

get '/heroku/deploy' do
	`git push heroku master`
	# it worked, but i think one of those instances it took more than 60 seconds.
	# should probably find a snazzy way to timestamp incoming requests
	# if more than 55seconds by the time of render has passed, insert the response into a 
	# database record.  then use ajax "no success" on the front end to kick off a spooling
	# process that will fetch the response, whenever it is eventually ready. 
end

get '/migration/create/:name' do
	`rake db:create_migration NAME=#{params[:name]}`
end

# #post
get '/github/create_repo/:name' do
	client = Octokit::Client.new(:login => params[:username], :password => params[:password])
	client.create_repository(params[:name])
end

get '/github/push_repo/:name' do
	`git remote add origin git@github.com:nelsonenzo/hashadmin.git`
	`git push -u origin master`
end