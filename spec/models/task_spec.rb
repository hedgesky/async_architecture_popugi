RSpec.describe Task, type: :model do
  it 'is valid with all of the attributes' do
    task = described_class.new(assignee_id: 'fake_id', description: 'fake')
    expect(task).to be_valid
  end

  it "isn't valid without description" do
    task = described_class.new(assignee_id: 'fake_id')
    expect(task).not_to be_valid
  end
end
