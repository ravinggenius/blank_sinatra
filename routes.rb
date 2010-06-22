class Application < Sinatra::Base
  get '/styles/:name.css' do
    content_type :css, :charset => 'utf-8'
    sass :"stylesheets/#{params[:name]}"
  end

  get '/favicon.ico' do
  end

  get '/' do
    haml :index
  end

  get '/:slug' do
    #not_found unless %w'clients contact services thanks'.include? params[:slug]
    haml :"#{params[:slug]}"
  end
end
