require 'sinatra'
require 'sinatra/reloader'
require './model'
require 'redcarpet'
#require 'json'

=begin
require 'bundler'
Bundler.require
=end

configure do
  set :bind, '0.0.0.0'
end

class CustomRedcarpet < Redcarpet::Render::HTML
  def table( header, body )
    #%(<table class='markdown-table-default'>#{header}#{body}</table>)
    %(<table border="1">#{header}#{body}</table>)
  end
end


helpers do
  def markdown_option( mdfile )
    render_options = {
      no_links: true,
      hard_wrap: true,
    }
    extensions = {
      tables: true,
      strikethrough: true,
      fenced_code_blocks: true,
    }

    #render = Redcarpet::Render::HTML.new( render_options )
    render = CustomRedcarpet.new( render_options )
    markdown mdfile, extensions, render: render
  end
end

get '/' do
  erb :index
end

get '/hello' do
  'How are you?'
end

get '/path/to' do
  "this is [/path/to]"
end

get '/hello/*' do |name|
  "hello #{name}. how are you?"
end

get '/erb_template_page' do
  erb :erb_template_page
end

get '/markdown_template' do
  markdown :md_template
end

get '/erb_and_md' do
  #erb :erb_and_md_page, :locals => { :md => markdown(:erb_and_md_page) }
  erb :erb_and_md_page 
end

get '/mdtest' do
  markdown_option :md_page
end

get '/message' do
  "number of messages #{Message.count}"
end

get '/message/show' do
  @messages = Message.all
  erb :message_show
end

get '/json' do
  @messages = Message.all
  outmsg = ""
  @messages.each do |m|
    outmsg << JSON.pretty_generate(m.attributes).gsub(/\R/, "<br>")
    outmsg << " <br>"
  end
  outmsg
  #@messages.to_json
end

get '/users' do
  "number of user #{User.count}"
end

get '/htmx' do
  #erb '/htmx/htmx_index'.to_sym
  erb :'/htmx/htmx_index'
end

get '/htmx/food' do
  erb '/htmx/food'.to_sym
end

area = {}
area[:kanto]   = %w( 東京 神奈川 埼玉 千葉  ) 
area[:kansai]  = %w( 大阪 兵庫 京都 奈良 和歌山 )
area[:sikoku]  = %w( 香川 高知 愛媛 徳島 )
area[:kyusyu]  = %w( 福岡 鹿児島 大分 宮崎 長崎 熊本 佐賀 )
area[:touhoku] = %w( 秋田 岩手 青森 福島 山形 宮城  )

get '/htmx/select_area' do
  key = params[:area]  
  @prefecture_list = area[ key.to_sym ]
  erb '/htmx/select_option'.to_sym
end

post '/htmx/destroy' do
  'Delete xxxx complete!'
end

get '/htmx/oob1' do
  erb '/htmx/oob1'.to_sym
end

get '/htmx/oob2' do
  erb '/htmx/oob2'.to_sym
end

post '/htmx/validate_post' do
  "validate OK ! params >> #{ params[:example] }"
end

post '/htmx/dialogs' do
  @headers = request.env.select { |k, v| k.start_with?('HTTP_HX_') }
  puts @headers
  erb '/htmx/dialogs'.to_sym
end


