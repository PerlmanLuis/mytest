class Micropost < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content
  
  
  validates :content, :length   => { :maximum => 140},
                      :presence => true
  
  validates :user_id, :presence => true
  
  default_scope :order => 'microposts.created_at DESC'
end

# == Schema Information
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

