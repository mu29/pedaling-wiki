require 'sinatra/activerecord'
require 'base64'

class User < ActiveRecord::Base

  validates_uniqueness_of :email
  validates_presence_of :password

  has_many :wikis
  has_many :replies

  before_create :generate_token

  def generate_token
    self.token = Base64.encode64("#{self.email}pedalingwiki")
  end
end
