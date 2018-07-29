require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  it { should validate_presence_of(:email)}
  it { should validate_presence_of(:username)}
  it { should have_secure_password }
  it { should validate_confirmation_of(:password)}

end
