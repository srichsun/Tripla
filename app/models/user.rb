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
  # Sleeping hours
  has_many :trackings, dependent: :destroy

  def clock_in(kind)
    self.routines.create!(kind: kind)
    adding_sleeping_record if kind == 'awake'
  end

  def adding_sleeping_record
    duration = routines.last.created_at - routines.second_to_last.created_at
    trackings.create!(duration: duration)
  end

  def sleeping_records
    sleeping_records = []
    trackings_from_last_week.each do |tracking|
      sleeping_records << { "#{tracking.created_at}": tracking.duration }
    end

    sleeping_records
  end

  def trackings_from_last_week
    trackings.where('created_at BETWEEN ? AND ?', Time.now - 7.days, Time.now)
  end

  def follow(user)
    self.following << user
  end

  def unfollow(user)
    user = self.chasing_relationships.find_by(followee_id: user.id)
    user.destroy unless user.nil?
  end
end
