class Wiki < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :user_id
  validates_uniqueness_of :version, scope: :title

  belongs_to :user
  has_many :replies

  before_create :generate_version

  def generate_version
    self.version = Wiki.where(title: self.title).size + 1
  end

  def self.find_wiki(title)
    where(title: title).order('created_at DESC').first
  end
end
