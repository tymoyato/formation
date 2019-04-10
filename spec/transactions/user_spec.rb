require 'rails_helper'

RSpec.describe CreateUser do
  describe '#User' do
    subject { described_class.new.call(user: random_user) }

    context 'create user with valid params' do
      let(:random_user) { build(:random_user) }

      it 'should create user' do
        expect(subject).to be_success
      end

      it 'should create user and save to database' do
        expect { subject }.to change(User, :count).by(+1)
      end
    end

    context 'given email params invalid' do
      let(:random_user) { build(:random_user, email: '111') }
      it 'shout not be valid with wrong email' do
        expect(subject).to be_failure
      end
    end

    context 'given params empty' do
      let(:random_user) { build(:random_user, first_name: nil) }
      it 'should not be valid with missing parameters' do
        expect(subject).to be_failure
      end
    end
  end
end