require 'spec_helper'

describe Blackout, type: :model do
  context 'validations and associations' do
    it { is_expected.to validate_presence_of(:notice) }
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:end_date) }
    it { is_expected.to validate_presence_of(:blackout_type) }

    it 'validates a set_id if it is a recurring blackout'
    # new feature that should exist already
  end

  describe 'get_notices_for_date' do
    before do
      @soft = FactoryGirl.create(:blackout,
                                 blackout_type: 'soft',
                                 notice: 'soft_notice')
      @hard = FactoryGirl.create(:blackout)
      @other_soft = FactoryGirl.create(:blackout,
                                       start_date: (Time.zone.today + 3.days),
                                       blackout_type: 'soft',
                                       notice: 'other notice')
      @other_hard = FactoryGirl.create(:blackout,
                                       start_date: (Time.zone.today + 3.days),
                                       notice: 'other notice again')
    end
    after(:all) do
      Blackout.delete_all
    end
    context 'all blackouts' do
      subject(:return_value) do
        Blackout.get_notices_for_date(Time.zone.today)
      end
      it 'should contain the soft notice' do
        expect(return_value).to include(@soft.notice)
      end
      it 'should contain the hard notice' do
        expect(return_value).to include(@hard.notice)
      end
      it 'should not contain the other notices' do
        expect(return_value).to_not include(@other_soft.notice)
        expect(return_value).to_not include(@other_hard.notice)
      end
    end
    context 'only hard blackouts' do
      subject(:return_value) do
        Blackout.get_notices_for_date(Time.zone.today, :hard)
      end
      it 'should contain the hard notice' do
        expect(return_value).to include(@hard.notice)
      end
      it 'should not contain any other notices' do
        expect(return_value).to_not include(@soft.notice)
        expect(return_value).to_not include(@other_soft.notice)
        expect(return_value).to_not include(@other_hard.notice)
      end
    end
    context 'only soft blackouts' do
      subject(:return_value) do
        Blackout.get_notices_for_date(Time.zone.today, :soft)
      end
      it 'should contain the soft notice' do
        expect(return_value).to include(@soft.notice)
      end
      it 'should not contain any other notices' do
        expect(return_value).to_not include(@hard.notice)
        expect(return_value).to_not include(@other_soft.notice)
        expect(return_value).to_not include(@other_hard.notice)
      end
    end
  end
end
