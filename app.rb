require 'boot'

require 'compass'
require 'sinatra'
require 'haml'
require 'pony'

Dir[Dir.pwd + '/models/*.rb'].each { |file| require file }

configure do
  set :app_file, __FILE__
  set :root, Dir.pwd
  set :haml, { :format => :xhtml, :attr_wrapper => '"' }

  Compass.configuration do |config|
    config.project_path = Dir.pwd
    config.sass_dir = 'views/stylesheets'
  end

  set :sass, Compass.sass_engine_options

  EMAIL_SETTINGS = {
    :via => :smtp,
    :smtp => {
      :host => 'smtp.sendgrid.net',
      :port => '25',
      :user => ENV['SENDGRID_USERNAME'],
      :password => ENV['SENDGRID_PASSWORD'],
      :auth => :plain,
      :domain => ENV['SENDGRID_DOMAIN'] || 'localhost.localdomain'
    }
  }
end

helpers do
  include Rack::Utils

  alias_method :h, :escape_html

  def featured_project project, options = {}
    @project = project
    @project.is_special = options[:is_special] || false
    partial :featured_project
  end

  def partial name, options = {}
    name = name.to_s
    name = "_#{name}" unless name.start_with? '_'
    options[:layout] = :none
    haml name.to_sym, options
  end
end

before do
  @site_name = 'Site Name'
  @site_tagline = 'site tagline...'

  @title = if request.path == '/'
    "#{@site_name} - #{@site_tagline}"
  elsif
    words = request.path
    words = words.split('/').pop.map { |s| s.capitalize }.compact.join ': '
    words = words.split('_').map { |s| s.capitalize }.compact.join ' '
    "#{words} - #{@site_name}"
  end
end

not_found do
  haml :not_found
end

load 'routes.rb'
