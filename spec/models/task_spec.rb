require 'rails_helper'

describe Task, type: :model do

  describe 'Schema' do
    describe 'Fields' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:description).of_type(:string) }
      it { is_expected.to have_db_column(:start).of_type(:datetime) }
      it { is_expected.to have_db_column(:end).of_type(:datetime) }
      it { is_expected.to have_db_column(:user_id).of_type(:integer) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    end

    describe 'Indices' do
      it { is_expected.to have_db_index(:user_id) }
    end
  end

  describe 'Validations' do
    # let(:subject) { Task.new(start: Time.current, end: Time.current + 1.hour) }

    it { is_expected.to validate_presence_of(:start) }
    it { is_expected.to validate_presence_of(:end) }
    it { is_expected.to validate_presence_of(:description) }

    describe 'Custom validations: ' do
      describe 'validates for start time to be greater than end time' do
        before do
          current_time = Time.current
          subject.start = current_time
          subject.end = current_time - 1.hour
          subject.valid?
        end

        it 'returns object as invalid' do
          expect(subject).to be_invalid
        end
        it 'adds 1 error in "start"' do
          expect(subject.errors[:start].count).to eq(1)
        end
        it 'adds error in "start" with "must be before end time."' do
          expect(subject.errors[:start]).to eql(['must be before end time.'])
        end
      end
    end
  end

end
