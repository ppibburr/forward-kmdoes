require 'sinatra'
require 'open-uri'
puts "hey"
require 'net/http'
puts "bye"

def http(method, path, body)
  body=body.read
  http = Net::HTTP.new("24.23.104.26",4567)
  req = Net::HTTP.const_get(method.to_s.capitalize.to_sym).new(path)
  req.body = body
  http.request(req).body
end

get '/*' do
  case request.path.split("/")[-1]
  when /.*\.jpg/
    content_type "img/jpg"
  when /.*\.png/
    content_type "img/png"
  when /.*\.svg/
    content_type "image/svg+xml"
  when /.*\.js/
    content_type "text/javascript"
  when /.*\.css/
    content_type "text/css"
  else
  end
  
  open('http://cmms.km-does.xyz'+request.fullpath).read
end

put "/*" do
  http(:put, request.fullpath,request.body)
end

post "/*" do
  http(:post, request.fullpath,request.body)
end

delete "/*" do
  http(:delete, request.fullpath) 
end
