class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  set :views, './app/views'
  set :public_folder, './app/statics'
  enable :sessions

  def render_template(template)
    folder = self.class.name.gsub('Controller', '').downcase
    erb :'layouts/base'do |type|
      case type
      when :stylesheet
        erb :"#{folder}/style"
      when :content
        erb :"#{folder}/#{template}"
      end
    end
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
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text)
  end
end
