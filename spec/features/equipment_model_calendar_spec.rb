require 'spec_helper'

RSpec.feature 'Equipment model calendar view' do
  context 'as admin or superuser' do
    before(:each) { sign_in_as_user(@admin) }
    after(:each) { sign_out }

    it 'shows a calendar view of reservations', :js do
      create_res_in_current_month(2)

      visit calendar_equipment_model_path(@eq_model)

      expect(page).to have_css '[data-role=cal-item]', count: 2
    end

    xit 'shows reservations in the current month' do
    end

    xit "doesn't show reservations last month" do
    end
  end

  context 'as non-admin' do
    shared_examples 'redirects to equipment model page' do
      # stuff
    end

    context 'as checkout person' do
      before(:each) { sign_in_as_user(@checkout_person) }
      after(:each) { sign_out }

      it_behaves_like 'redirects to equipment model page'
    end

    context 'as patron' do
      before(:each) { sign_in_as_user(@user) }
      after(:each) { sign_out }

      it_behaves_like 'redirects to equipment model page'
    end

    context 'as banned user' do
      before(:each) { sign_in_as_user(@banned) }
      after(:each) { sign_out }

      it_behaves_like 'redirects to equipment model page'
    end
  end

  def create_res_in_current_month(count = 1)
    fail InvalidParameterError if count > 28
    day0 = Time.zone.today.beginning_of_month # to ensure it's in this month
    (1..count).each do |i|
      # make sure it's a 1-day reservation so there's only a single cell
      # (avoid weekend overlaps)
      res1 = build :reservation, equipment_model: @eq_model,
                                 start_date: day0 + (i - 1).days,
                                 due_date: day0 + (i - 1).days
      res1.save(validate: false)
    end
  end
end
