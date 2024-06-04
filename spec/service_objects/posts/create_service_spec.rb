require 'rails_helper'

RSpec.describe ::Posts::CreateService do
  describe '.new' do
    context 'trying to create instance with invalid params' do

      it 'Raises an error' do
        expect { described_class.new(title: nil, content: 'a', user: double(User)) }.to raise_error(::Errors::InvalidParamError)
        expect { described_class.new(title: 'b', content: nil, user: double(User)) }.to raise_error(::Errors::InvalidParamError)
        expect { described_class.new(title: 'b', content: 'a', user: nil) }.to raise_error(::Errors::InvalidParamError)
      end
    end
  end

  describe '#call' do
    context 'when creating a post without a tag' do
      subject { ::Posts::CreateService.new(title:, content:, user:) }
      let!(:user) do
        User.create_or_find_by(
          name:                  'Admin',
          email:                 'admin@test.com',
          password:              '123456',
          password_confirmation: '123456',
          role:                  'admin'
        ).tap do |admin|
          admin.confirm
        end
      end

      let(:title) { 'Post Title' }
      let(:content) { Faker::Lorem.sentence(word_count: 300) }

      it 'creates the post without tags' do
        subject.call.tap do |post_instance|
          expect(post_instance).to be_persisted
          expect(post_instance).to have_attributes(title:, user:)
          expect(post_instance.tags.count).to eq 0
        end
      end
    end
  end
end
