require 'sinatra'
require 'maruku'

get '/' do
  erb :home
end

get '/:factor' do |factor|
  @factor = factor
  erb :factor
end

helpers do
  def render_markdown(file)
    markdown = File.read("content/#{file}.md")
    Maruku.new(markdown).to_html
  rescue Errno::ENOENT
    halt 404
  end
end

not_found do
  "Page not found"
end
