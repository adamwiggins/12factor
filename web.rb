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
  end
end
