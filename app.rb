set :root, File.dirname(__FILE__)

get '/' do
  haml :index
end
