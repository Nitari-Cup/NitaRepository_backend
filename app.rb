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
