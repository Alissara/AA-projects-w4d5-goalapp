# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  # validations
  # associations
  # class methods
  subject(:user) { FactoryGirl.create(:user)}


  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_presence_of(:session_token) }
    it { should validate_uniqueness_of(:session_token) }
  end

  describe 'associations' do
    it { should have_many(:goals) }
  end

  describe 'class methods' do
    describe '::find_by_credentials' do
      it 'return nil if user not found' do
        expect(User.find_by_credentials(nil, 'password')).to be_nil
      end
      it 'returns user if found' do
        user = User.create(username: :bob, password: :password)
        expect(User.find_by_credentials('bob', 'password')).to eq(user)
      end
    end
  end

  describe 'instance methods' do
    subject(:bob){User.create(username: :bob, password: :password)}
    describe '#is_password?'do

      it 'returns true with correct password' do
        expect(bob.is_password?(:password)).to be true
      end
      it 'returns false with incorrect password' do
        expect(bob.is_password?(:bad_password)).to be false
      end
    end

    describe '#reset_session_token!' do
      it 'resets the session_token' do
        token = bob.session_token
        bob.reset_session_token!
        expect(token).not_to eq(bob.session_token)
      end
    end

  end


end
