class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  #set :root, './app'
  set :views, './app/views'

  def render_template(template)
    folder = self.class.name.gsub('Controller', '').downcase
    erb :'layouts/base' do
      erb :"#{folder}/#{template}"
    end
  end
end
