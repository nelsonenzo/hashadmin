require 'sinatra'

@default_layout = :layout

MOBILE_USER_AGENTS = 'palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\.b|webos|amoi|novarra|cdm|alcatel|pocket|iphone|mobileexplorer|ipad|mobile'

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
	require './admin'
end
