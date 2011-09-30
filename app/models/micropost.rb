class Micropost < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content
  
  
  validates :content, :length   => { :maximum => 140},
                      :presence => true
  
  validates :user_id, :presence => true
  
  default_scope :order => 'microposts.created_at DESC'
  
  scope :from_users_followed_by, lambda { |user| followed_by(user)}
  
  private
  
    def self.followed_by(user)
      followed_ids = %(SELECT followed_id FROM relationships
                       where follower_id = :user_id)
      where("user_id IN (#{followed_ids}) OR user_id = :user_id", :user_id => user)
    end
    
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

