class MentionsNotifier
  def initialize(comment)
    @comment = comment
  end

  def call
    usernames.each do |username|
      user = User.find_by(username: username)
      next if user.nil? || user == @comment.user

      Notification.create!(user: user, comment: @comment)
    end
  end

  private

  def usernames
    @comment.body.scan(/@(\w+)/).flatten.uniq
  end
end
