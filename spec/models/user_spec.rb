require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {build(:user)}

  #before { @user = FactoryBot.build(:user) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_confirmation_of(:password) }
  it { is_expected.to allow_value('costa@nonato.com').for(:email) }
  it { is_expected.to validate_uniqueness_of(:auth_token) }

describe "#info" do
  it "returns email, created_at and token" do
    user.save!
    allow(Devise).to receive(:friendly_token).and_return('abc123zyzTOKEN')
    expect(user.info).to eq("#{user.email} - #{user.created_at} - Token: abc123zyzTOKEN")
  end
end
describe "#generate_authentication_token!" do
  it "gerates a unique authentication token" do
    allow(Devise).to receive(:friendly_token).and_return('abc123zyzTOKEN')
    user.generate_authentication_token!
    expect(user.auth_token).to eq('abc123zyzTOKEN')
  end
  it "generates another auth token when the current auth token already has been taken" do
    allow(Devise).to receive(:friendly_token).and_return('abc123tokenxyz', 'abc123tokenxyz', 'abcXYZ123456789')
    existing_user = create(:user)
    user.generate_authentication_token!
    expect(user.auth_token).not_to eq(existing_user.auth_token)
  end
end




end
