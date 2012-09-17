####### OFFICIAL NAME: #Ops  hashops   ###########
## domain is available, not a lot of google competition, kinda discriptive

## Rather than using backtics, I should probaly learn and use the real IO library
## http://www.ruby-doc.org/core-1.9.3/IO.html#method-c-new

require 'octokit'
require 'json'

get '/hashops' do
	erb :"hashops/index", :layout => :"hashops/hashops_layout"
end

get '/hashops/rvm' do
	erb :"hashops/rvm", :layout => :"hashops/hashops_layout"
end

get '/hashops/git' do
	erb :"hashops/git", :layout => :"hashops/hashops_layout"
end

get '/hashops/github' do
	erb :"hashops/github", :layout => :"hashops/hashops_layout"
end

get '/hashops/database' do
	erb :"hashops/database", :layout => :"hashops/hashops_layout"
end

get '/hashops/deploy' do
	erb :"hashops/deploy", :layout => :"hashops/hashops_layout"
end


get '/hashops/rvm/list' do
	command_sent = 'rvm list'
	console_response = `rvm list`
	rubies = console_response.split("\n").reject{|r| !r.match(/.*ruby.*[0-9]+.*/) }
	rubies.map! do |r|
		status = case r
			when r.include?('=>')	"current"
			when r.include?('=*')	"current_and_default"
			when r.include?('*')	"default"
			else ""
			end
		ruby = r.gsub(/ \[.*\]/,'').gsub(/[=>*]/,'').strip
		{'ruby'=>ruby, 'status'=>status}
	end
	content_type :json
  	{:command_sent => command_sent, 
  		:console_response => console_response,
  		:formated_response => rubies}.to_json
	# %x[rvm list] #does the same as above, but uglier! maybe useful if you ever need quotes.
	#downside to both these is that it does not get stderr, just stdout.
end

get '/hashops/rvm/set_ruby' do
	ver = params[:version]
	name = params[:gemset_name]
	command_sent = "rvm #{ver} do rvm gemset create #{name}"
	# The trick to operating rvm from io:
	# https://rvm.io/workflow/scripting/
	console_response = `#{command_sent}`
	content_type :json
		{:command_sent => command_sent, 
			:console_response => console_response}.to_json
end

get '/hashops/rvm/create_rvmrc' do
	# write out a template file with the appropriate gemset to use.
end

get '/hashops/gem/install/:gem' do
	`gem install #{params[:gem]}`
end

get '/hashops/gem/bundle/install' do
	`bundle install`
end

get '/hashops/git/init' do
	`git init`
end

get '/hashops/git/add_all' do
	`git add *`
end

get '/hashops/git/commit_1' do
	`git commit -m "first commit"`
end

get '/hashops/git/commit/any/:message' do
	#git quick commit of any changes that have been made - this is dangerous.
end

get '/hashops/git/github/create' do
	#create the gitub repo
end

post '/hashops/git/github/share' do
	#using github api, share to git usernames/email addresses
end

get '/hashops/heroku/sign_in' do
	#multi part step, if at all possible, probably need one of the fancier
	#io options.  check out http://tech.natemurray.com/2007/03/ruby-shell-commands.html
end

get '/hashops/heroku/create' do
	`heroku create`
end

get '/hashops/heroku/deploy' do
	`git push heroku master`
	# it worked, but i think one of those instances it took more than 60 seconds.
	# should probably find a snazzy way to timestamp incoming requests
	# if more than 55seconds by the time of render has passed, insert the response into a 
	# database record.  then use ajax "no success" on the front end to kick off a spooling
	# process that will fetch the response, whenever it is eventually ready. 
end

get '/hashops/deploy/elsewhere' do
	# do a google search for:
	# what does capify! do
	# to see a variety of capistrano generating gems
	# for deploying to other places.
end

get '/hashops/migration/create/:name' do
	`rake db:create_migration NAME=#{params[:name]}`
end

# #post
get '/hashops/github/create_repo/:name' do
	client = Octokit::Client.new(:login => params[:username], :password => params[:password])
	client.create_repository(params[:name])
end

get '/hashops/github/push_repo/:name' do
	`git remote add origin git@github.com:nelsonenzo/hashadmin.git`
	`git push -u origin master`
end

get '/hashops/gem/add/:gemname' do
	append_file "./Gemfile", "\ngem '#{params[:gemname]}'\n"
	"hi" #need to return something here that is not 
end

def append_file(dest,data)
	path = dest
	data = "#{data}"
	File.open(path, 'a+') {|file| file.write(data)}
	# see http://stackoverflow.com/questions/1581674/differences-between-ruby-file-access-mode-r-and-w
end

## Additional Feature Possibilites

## would be cool if there was a little admin database seperate from the 
## project db to store project info - like the name of the gemset, heroku app name, etc.
## maybe it's even a system database that has 'All Projects' info.
## be wary of 'history' - you won't see other committers mods.
## probably best to only save things related to this system or global to the world, like
## heroku project name,etc.