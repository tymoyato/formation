require 'rails_helper'

RSpec.describe CreateUser do
  describe '#user' do
    subject { described_class.call(params: params) }

    context 'when params are valid' do
      let(:random_user) { attributes_for(:random_user) }
      it 'should create user' do
        create_user = CreateUser.new
        expect(create_user.call(random_user)).to be_success
      end

      it 'should create user and save to database' do
        create_user = CreateUser.new
        expect { create_user.call(random_user) }.to change(User, :count).by(+1)
      end
    end

    context 'given params bad email format' do
      let(:random_user) { attributes_for(:random_user, email: '111') }
      it 'shout not be valid with wrong email' do
        create_user = CreateUser.new
        expect(create_user.call(random_user)).to be_failure
      end
    end

    context 'given missing parameters' do
      let(:random_user) { attributes_for(:random_user, first_name: '') }
      it 'should not be valid with missing parameters' do
        create_user = CreateUser.new
        expect(create_user.call(random_user)).to be_failure
      end
    end
  end
end
