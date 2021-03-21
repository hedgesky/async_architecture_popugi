# not an AR model!
class Account
  attr_reader :id, :email, :role

  def initialize(id:, email:, role:)
    @id = id
    @email = email
    @role = role
  end

  def self.all
    [
      new('fake_id_1', 'Vasily'),
      new('fake_id_2', 'Elena'),
      new('fake_id_3', 'Konstantin'),
      new('fake_id_4', 'Olga'),
      new('fake_id_5', 'Piotr'),
    ]
  end

  def self.find_by(id:)
    all.detect { |user| user.id == id }
  end
end
