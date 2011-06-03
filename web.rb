require 'sinatra'
require 'maruku'

get '/' do
  erb :home
end

TOC = %w(repo dependencies config)

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

  def render_prev(factor)
    idx = TOC.index(factor)
    return if idx == 0
    "<a href=\"/#{TOC[idx-1]}\">&laquo; Previous</a>"
  end

  def render_next(factor)
    idx = TOC.index(factor)
    return if idx == TOC.size-1
    "<a href=\"/#{TOC[idx+1]}\">Next &raquo;</a>"
  end
end

not_found do
  "Page not found"
end
