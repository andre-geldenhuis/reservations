require 'spec_helper'

RSpec.feature 'Equipment model calendar view' do
  scenario 'as admin or superuser' do
    before(:each) { sign_in_as_user(@admin) }
    after(:each) { sign_out }

    it 'shows a calendar view of reservations' do
      day0 = Time.zone.today.beginning_of_month # to ensure it's in this month
      res1 = create :reservation, equipment_model: @eq_model,
                                  start_date: day0,
                                  due_date: day0 + 1.day

      visit equipment_model_calendar_path(@eq_model)

      # test for existence of calendar view (CSS selector as well?)
      expect(page).to have_link "Res. ##{res1.id}"
    end

    xit 'shows reservations in the current month' do
    end

    xit "doesn't show reservations last month" do
    end
  end

  scenario 'as non-admin' do
    shared_example 'redirects to equipment model page' do
      # stuff
    end

    it 'as checkout person' do
      sign_in_as_user(@checkout)
      # visit route
      it_behaves_like 'redirects to equipment model page'
      sign_out
    end

    it 'as patron' do
      sign_in_as_user(@patron)
      # visit route
      it_behaves_like 'redirects to equipment model page'
      sign_out
    end

    it 'as banned user' do
      sign_in_as_user(@banned)
      # visit route
      it_behaves_like 'redirects to equipment model page'
      sign_out
    end
  end
end
