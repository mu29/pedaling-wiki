class WikisController < ApplicationController
  get '/wikis' do
    render_template :index
  end
end
