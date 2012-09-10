get '/rvm/rubies' do
	result = `rvm list`
	result
end

get '/rvm/set_ruby' do
	ver = 'ruby-1.9.2-p290'
	result = `rvm #{ver}`
	# crappy - this doesn't work.  maybe better luck with rbenv
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