class FetchUserTasks
  def initialize(user)
    @user = user
  end

  def call
    Task.where(assignee_id: @user.id)
  end
end