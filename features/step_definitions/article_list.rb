require 'rspec/expectations'
require 'httparty'

When(/^the client requests GET \/articles$/) do
  @last_response = HTTParty.get('http://localhost:9999' + '/articles')
end

Then(/^the response should be JSON:$/) do |json|
  expect(JSON.parse(@last_response.body)).to eq(JSON.parse(json))
end