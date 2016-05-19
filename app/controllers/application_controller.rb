class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  configure do
    set :views, './app/views'
    set :public_folder, './app/statics'
    enable :sessions
  end

  configure :production do
    set :raise_errors, false
    set :show_exceptions, false
  end

  error do
    erb :'layouts/base' do |type|
      case type
      when :stylesheet
        erb :'wikis/style'
      when :content
        erb :'layouts/error'
      end
    end
  end

  def render_template(template, message = session[:message])
    folder = self.class.name.gsub('Controller', '').downcase
    session[:message] = message
    erb :'layouts/base' do |type|
      case type
      when :stylesheet
        erb :"#{folder}/style"
      when :content
        erb :"#{folder}/#{template}"
      end
    end
  end

  def redirect_message(url, message)
    session[:message] = message
    redirect url
  end

  def logged_in?
    !session[:token].nil?
  end

  def current_user
    User.find_by(token: session[:token])
  end

  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
    }

    extensions = {
      autolink: true,
      superscript: true,
      strikethrough: true,
      highlight: true,
    }

    renderer = WikiRenderer.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text)
  end

  def to_url(url)
    url = URI.escape(url)
    url.sub('?', '%3F')
  end
end

class WikiRenderer < Redcarpet::Render::Safe
  def codespan(code)
    if code.include? "\n"
      code = code.split("\n").reduce do |result, element|
        result + element + "\n" unless element.empty?
      end
      code = code[0 .. code.length - 2]
      puts code
      "<pre>" \
        "<code>#{html_escape(code)}</code>" \
      "</pre>"
    else
      "<code>#{html_escape(code)}</code>"
    end
  end
end
