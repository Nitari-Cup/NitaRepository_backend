require 'sinatra'
require 'sinatra/base'
require 'json'
require 'csv'
require 'uri'
require 'net/http'


get '/' do
	article = {
		id: 1,
		title: 'this is test',
		content: 'hello world'	
	}
	
	article.to_json
end

post '/postReview' do
	body = JSON.parse(request.body.read)
	body.to_json
end


get '/fetchReview' do
	body = {
		test: 'hello'
	}

	body.to_json
end


get '/fetchQuestion' do
	body = {
		test: 'hello'
	}

	body.to_json
end



