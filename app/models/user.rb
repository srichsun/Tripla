class User < ApplicationRecord
  # people who I follow
  has_many :chasing_relationships, class_name:  "Follow",
                                   foreign_key: "follower_id",
                                   dependent:   :destroy
  has_many :following, through: :chasing_relationships, source: :followee

  # people who follow me
  has_many :getting_relationships, class_name:  "Follow",
                                   foreign_key: "followee_id",
                                   dependent:   :destroy
  has_many :followers, through: :getting_relationships, source: :follower

  # has many clock in times
  has_many :routines

  def clock_in(kind)
    self.routines.create!(kind: kind)
  end

  def follow(user)
    self.following << user
  end

  def unfollow(user)
    user = self.chasing_relationships.find_by(followee_id: user.id)
    user.destroy unless user.nil?
  end
end
