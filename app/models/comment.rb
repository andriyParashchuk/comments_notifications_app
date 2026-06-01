class Comment < ApplicationRecord
  include Meilisearch::Rails

  meilisearch do
    searchable_attributes [:body]
  end

  belongs_to :user

  has_many :notifications, dependent: :destroy

  after_create_commit -> { MentionsNotifier.new(self).call }

  validates :body, presence: true
end
