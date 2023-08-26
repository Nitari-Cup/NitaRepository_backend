require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'
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



