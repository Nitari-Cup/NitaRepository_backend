require 'sinatra'
require 'json'
require 'csv'
require 'uri'
require 'net/http'
require 'rubygems'
require 'bundler'

Bundler.require

set :bind, "0.0.0.0"
port = ENV["PORT"] || "8080"
set :port, port

before do
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST'
    response.headers['Access-Control-Allow-Headers'] = 'Content-Type'

    halt(200) if request.request_method == 'OPTIONS'
end

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
	questionsTable = {}

	body = File.open('./questions.csv').read
	csv = CSV.new(
		body,
		headers: true,
		force_quotes: true
	)
	
	rows = csv.to_a.map { |row| row.to_hash }
	rows.each.with_index(1) do |row, i|
		questionsTable[i] = row
	end

	questionsTable.to_json
end



