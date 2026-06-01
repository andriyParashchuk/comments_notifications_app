class Comment < ApplicationRecord
  belongs_to :user

  has_many :notifications, dependent: :destroy

  after_create_commit :create_mention_notifications

  validates :body, presence: true

  def create_mention_notifications
    usernames = body.scan(/@(\w+)/).flatten.uniq

    usernames.each do |username|
      mentioned_user = User.find_by(username: username)

      next if mentioned_user.blank?
      next if mentioned_user == user

      Notification.create!(
        user: mentioned_user,
        comment: self
      )
    end
  end
end
