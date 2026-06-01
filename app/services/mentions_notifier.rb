class MentionsNotifier
  def initialize(comment)
    @comment = comment
  end

  def call
    return if usernames.empty?

    users = User.where(username: usernames).where.not(id: @comment.user_id)
    return if users.empty?

    notifications_data = users.map do |user|
      {
        user_id: user.id,
        comment_id: @comment.id,
        created_at: Time.current,
        updated_at: Time.current
      }
    end

    Notification.insert_all(notifications_data)
  end

  private

  def usernames
    @comment.body.scan(/@(\w+)/).flatten.uniq
  end
end
