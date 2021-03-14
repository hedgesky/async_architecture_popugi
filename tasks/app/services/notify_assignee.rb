class NotifyAssignee
  def initialize(task:)
    @task = task
  end

  def call
    user_id = @task.assignee_id
    Rails.logger.info("Notifying #{user_id} about new task via email")
    Rails.logger.info("Notifying #{user_id} about new task via Slack")
    Rails.logger.info("Notifying #{user_id} about new task via SMS")
  end

  def self.call(...)
    new(...).call
  end
end
