require 'sinatra'
require 'mobile_user_agents'

@default_layout = :layout

#not sure if you need this
# require 'data_mapper'
# definitely need this
#DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/recall.db")


# routes defined inline
get '/' do
  # if is_mobile_device?(request.env['HTTP_USER_AGENT']) and not matchy("ipad",request.env['HTTP_USER_AGENT'])
    # erb :index_mobile, :layout => :layout_mobile
  # else
    @current_user = true
    erb :index
  # end
end

if ENV['RACK_ENV'] == "development"
	require './hashadmin'
end
