require 'spec_helper'

shared_examples_for 'calendarable' do |model|
  before(:each) do
    @obj = FactoryGirl.create(model.class.to_s.underscore.to_sym)
  end

  context 'GET calendar' do
    it 'stores reservations for the object' do
      expect(assigns(:calendar_res)).to include(@res)
    end
  end

end

# TODO: we need a way to generate two reservations for a given model - one that
# will be chosen in the relevant query and one that won't. Those reservations
# should overlap and be on the first day of the current month. We need to store
# the relevant object to ensure we can issue request with the correct params
# and set expectations appropriately and also the two reservations

# TODO: we also need to test the various response formats, .json and .ical

def gen_category_res(cat = nil)
  cat ||= FactoryGirl.create(:category)
  cat2 = FactoryGirl.create(:category)

  em1 = FactoryGirl.create(:equipment_model, category: @obj)
  em2 = FactoryGirl.create(:equipment_model, category: cat2)

  ei1 = FactoryGirl.create(:equipment_item, equipment_model: em1)
  ei2 = FactoryGirl.create(:equipment_item, equipment_model: em2)

  day0 = Time.zone.today
  @res = FactoryGirl.create
end

def gen_equipment_model_res(mod = nil)
end

def gen_equipment_item_res(item = nil)
end