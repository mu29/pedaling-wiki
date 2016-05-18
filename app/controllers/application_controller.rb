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

  def login?
    !session[:token].nil?
  end
end
