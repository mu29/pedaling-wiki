require 'sinatra/activerecord'

class User < ActiveRecord::Base
  validates_uniqueness_of :email
  validates_presence_of :password

  has_many :wikis
  has_many :replies
end
