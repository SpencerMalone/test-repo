require 'sinatra'

post '/ghevent' do
  status 204 #successful request with no body content
  
  request.body.rewind
  request_payload = JSON.parse(request.body.read)
  
  #append the payload to a file
  File.open("events.txt", "a") do |f|
    f.puts(request_payload)
  end
  
  result = Net::HTTP.get(URI.parse("https://api.github.com/repos/SpencerMalone/test-repo/contents/Jenkinsfile?ref=refs/pull/#{request_payload['number']}/merge"))
  puts result
end
