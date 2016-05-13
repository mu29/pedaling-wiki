class WikisController < ApplicationController
  get '/wikis' do
    render_template :index
  end

  get '/wikis/new' do
    render_template :new
  end
end
