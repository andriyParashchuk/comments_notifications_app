class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  scope :unread, -> { where(read_at: nil) }

  def read?
    read_at.present?
  end
end
