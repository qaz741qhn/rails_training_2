require 'rails_helper'

RSpec.describe 'Session', type: :model do

  describe 'test' do
    let!(:user) { create(:user) }
    let!(:session) { create(:session, user_id: user.id, token_digest: "aaaaa", expires_at: DateTime.current.since(10.days)) }

    context 'test' do
      it 'true' do
        expect(session.user_id).to eq user.id
      end
    end

    context 'login streak' do
      before do
        user.created_at = 1.day.ago
        user.login_streak = 1
        user.updated_at = Time.current
        user.login_streak_count!
      end
      it 'streak increase' do
        expect(user.login_streak).to eq 2
      end
    end

  end