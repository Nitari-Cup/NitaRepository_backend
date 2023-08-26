require 'sinatra'
require 'json'
require 'csv'
require 'uri'
require 'net/http'
require 'rubygems'
require 'bundler'

#$Bundler.require

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
	request_body = JSON.parse(request.body.read)

	begin
		headers = CSV.open('./review.csv', col_sep: "\t").readline[0].split(',')
		new_row = []	

		headers.each do |header| 
			new_row.push(request_body[header])
		end
		puts "\n\n\n"
		puts new_row

		CSV.open('./review.csv', 'a') do |csv|
			csv << new_row
		end
	rescue => e
		puts e
		{"is_success": false}.to_json
	else
		{"is_success": true}.to_json
	end
end


get '/fetchReview' do
	body = {
		test: 'hello'
	}

	body.to_json
end


get '/fetchQuestion' do
	questionsTable = {}

	file = File.open('./questions.csv').read
	csv = CSV.new(
		file,
		headers: true,
		force_quotes: true
	)
	
	rows = csv.to_a.map { |row| row.to_hash }
	rows.each.with_index(1) do |row, i|
		questionsTable[i] = row
	end

	questionsTable.to_json
end



