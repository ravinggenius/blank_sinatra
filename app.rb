require 'rubygems'
require 'sinatra'
require 'haml'
require 'compass'

configure do
  Compass.configuration do |config|
    config.project_path = File.dirname(__FILE__)
    config.sass_dir = 'views/stylesheets'
  end

  set :haml, { :format => :html5 }
  set :sass, Compass.sass_engine_options
end

get '/' do
  haml :index
end

get '/styles/screen.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :screen
end
