require 'rails_helper'

RSpec.describe Comment, type: :model do
  
  # Longer way to test the model, but also correct
  
  # subject { described_class.new(body: 'body', post_id: 1) }
  # it 'is valid with valid attributes' do
  #   expect(subject).to be_valid
  # end
  # it 'is not valid without a body' do
  #   subject.body = nil
  #   expect(subject).to_not be_valid
  # end
  # it 'is not valid without a post id' do
  #   subject.post_id = nil
  #   expect(subject).to_not be_valid
  # end

  # Simpler way to test the present of attributes but requires Shoulda/matchers gem
  describe 'Associations' do
    it { should belong_to(:post).class_name('Post') }
  end

  describe 'Validations' do
    # it { should validate_presence_of(:post) } TODO: Fix this test
    it { should validate_presence_of(:body) }
  end

end
