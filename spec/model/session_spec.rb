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
  end
end