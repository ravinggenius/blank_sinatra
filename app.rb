require File.dirname(__FILE__) + '/vendor/gems/environment'

Bundler.require_env

get '/' do
  haml :index
end
