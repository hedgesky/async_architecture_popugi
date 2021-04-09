# Ideally, should be split into 3 different jobs so that each could be retried separately.
# Maybe in future :ok_hand:
class NotifyAssignee
  def initialize(task:)
    @task = task
  end

  def call
    account_id = @task.assignee_id
    return unless account_id

    data = Clients::Auth.account_data(account_id)

    Rails.logger.info("Sending email to #{data.email}: '#{text}'")
    Rails.logger.info("Sending Slack message to #{data.slack}: '#{text}'")
    Rails.logger.info("Sending SMS to #{data.phone}: '#{text}'")
  end

  def self.call(...)
    new(...).call
  end

  private

  def text
    "You are assigned to task #{@task.id}. Task's description: #{@task.description}"
  end
end
