class CurrentAccount
  attr_reader :id, :email, :role

  def initialize(id:, email:, role:)
    @id = id
    @email = email
    @role = role
  end

  def allowed_to_assign?
    role.to_s == 'manager' || role.to_s == 'admin'
  end
end