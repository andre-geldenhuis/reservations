module Calendarable
  extend ActiveSupport::Concern

  included do
    # before filters and such
  end

  def calendar
    @calendar_res = generate_calendar_reservations

    # extract calendar data
    respond_to do |format|
      format.html
      format.ics {} # render text: Ical.new(@calendar_res).to_ical }
    end
  end

  private

  def generate_calendar_reservations
    fail MethodNotImplemented
  end
end
