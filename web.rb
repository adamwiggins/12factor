require 'sinatra'
require 'redcarpet'

get '/' do
  erb :home
end

TOC = %w(codebase dependencies config backing-services build-release-run processes port-binding concurrency disposability dev-prod-parity logs admin-processes)

get '/:factor' do |factor|
  halt 404 unless TOC.include?(factor)
  @factor = factor
  erb :factor
end

helpers do
  def render_markdown(file)
    text = File.read("content/#{file}.md")
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
      :fenced_code_blocks => true,
      :no_intra_emphasis => true,
      :autolink => true,
      :strikethrough => true,
      :lax_html_blocks => true,
      :superscript => true,
      :hard_wrap => true,
      :tables => true,
      :xhtml => true)
    markdown.render(text)
  rescue Errno::ENOENT
    puts "No content for #{file}, skipping"
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
