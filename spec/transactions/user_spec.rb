require 'rails_helper'

RSpec.describe CreateUser do
  context 'create user' do
    let(:random_user) { attributes_for(:random_user) }
    it 'should create user' do
      create_user = CreateUser.new
      expect(create_user.call(user)).to be_success
    end

    let(:random_user) { attributes_for(:random_user) }
    it 'should create user and save to database' do
      create_user = CreateUser.new
      expect { create_user.call(user) }.to change(User, :count).by(+1)
    end

    let(:random_user) { attributes_for(:random_user, email: '111') }
    it 'shout not be valid with wrong email' do
      create_user = CreateUser.new
      expect(create_user.call(random_user)).to be_failure
    end

    let(:random_user) { attributes_for(:random_user, first_name: '') }
    it 'should not be valid with missing parameters' do
      create_user = CreateUser.new
      expect(create_user.call(random_user)).to be_failure
    end
  end
end