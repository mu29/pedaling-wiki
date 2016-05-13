class Reply < ActiveRecord::Base
  validates_presence_of :content
  validates_presence_of :user_id

  belongs_to :user
  belongs_to :wiki
end
