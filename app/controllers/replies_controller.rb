class RepliesController < ApplicationController
  get '/replies' do
    render_template :index
  end
end
