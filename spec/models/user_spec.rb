require 'rails_helper'
require 'bcrypt'

describe User, type: :model do

  describe 'Schema' do
    describe 'Fields' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:email).of_type(:string) }
      it { is_expected.to have_db_column(:password_hash).of_type(:string) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    end

    describe 'Indices' do
      it { is_expected.to have_db_index(:email).unique(true) }
    end
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_uniqueness_of(:email).allow_blank }

    describe 'Custom validations: ' do
      let(:correct_email) { 'correct_email@example.com' }
      let(:wrong_email) { 'wrong_email_format' }

      describe 'validates for correct email format' do
        context 'when email is provided in wrong format' do
          before do
            subject.email = wrong_email
            subject.valid?
          end

          it 'returns object as invalid' do
            expect(subject).to be_invalid
          end
          it 'adds 1 error in "email"' do
            expect(subject.errors[:email].count).to eq(1)
          end
          it 'adds error in "email" with "is not an email"' do
            expect(subject.errors[:email]).to eql(['is not an email'])
          end
        end

        context 'when email is provided in right format' do
          before do
            subject.email = correct_email
            subject.valid?
          end

          it 'should have 0 errors in "email"' do
            expect(subject.errors[:email].count).to eq(0)
          end
        end
      end
    end
  end

  describe 'Associations' do
    it { is_expected.to have_many(:tasks) }
  end

  describe 'Public methods' do
    let(:user) { User.new }

    describe '#password' do
      context 'when password_hash is nil' do
        before { @result = user.password }
        it 'returns nil' do
          expect(@result).to be(nil)
        end
      end

      context 'when password_hash is not blank' do
        let(:password_plain) { SecureRandom.alphanumeric(16) }
        let(:password_hash) { BCrypt::Password.create(password_plain) }
        let(:password) { BCrypt::Password.new(password_hash) }

        before do
          user.password_hash = password_hash
          @result = user.password
        end
        it 'returns encrypted object of BCrypt::Password class with plain password as input to it.' do
          expect(@result).to eql(password)
        end
      end
    end

    describe '#password=(password_arg)' do
      context 'when password_arg is nil' do
        before { @result = user.password }
        it 'returns nil' do
          expect(@result).to be(nil)
        end
      end

      context 'when password_arg is not blank' do
        let(:password_plain) { SecureRandom.alphanumeric(16) }
        let(:password_hash) { BCrypt::Password.create(password_plain) }
        let(:password) { BCrypt::Password.new(password_hash) }

        before do
          user.password = password_plain
          @result = user.password_hash
        end
        it 'sets password_hash to encrypted object of BCrypt::Password class with different salt.' do
          expect(@result).not_to eql(password_hash)
          expect(@result).not_to eql(password_plain)
        end
      end
    end

    describe '#validate_password(password)' do
      let(:password_plain) { SecureRandom.alphanumeric(16) }
      let(:correct_password) { password_plain }
      let(:wrong_password) { password_plain + 'wrong_password' }

      before { user.password = password_plain }

      context 'when provided password is valid' do
        before { @result = user.validate_password(correct_password) }

        it 'returns true' do
          expect(@result).to be(true)
        end
      end

      context 'when provided password is valid' do
        before { @result = user.validate_password(wrong_password) }

        it 'returns false' do
          expect(@result).to be(false)
        end
      end
    end

  end
end
