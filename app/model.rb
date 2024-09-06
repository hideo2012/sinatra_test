# database setting  ==> config/database.yml
require 'sinatra/activerecord'

set :environment, :development

class Message < ActiveRecord::Base 
end

class User < ActiveRecord::Base 
end

class Book < ActiveRecord::Base
end


=begin
require 'active_record'

config = YAML.load_file('./config/database.yml')
ActiveRecord::Base.establish_connection( config['development'] )

config = YAML.load_file('./config/database.yml')
ActiveRecord::Base.configurations = config
ActiveRecord::Base.establish_connection( 'development' )

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3", 
  database: "db/sina_test.db"
)

require "sinatra/activerecord"
namespace :db do
  task :load_config do
    require 'bundler'
    Bundler.require
    set :database, { 
      adapter: "sqlite3",
      database: "db/booking.db"
    }
  end
end

require 'bundler'
Bundler.require

# database setting  ==> config/database.yml
=end
