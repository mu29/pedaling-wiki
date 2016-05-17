class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  set :views, './app/views'
  set :public_folder, './app/statics'
  enable :sessions

  def render_template(template)
    folder = self.class.name.gsub('Controller', '').downcase
    erb :'layouts/base' do
      erb :"#{folder}/#{template}"
    end
  end

  def login?
    !session[:email].nil?
  end
end
