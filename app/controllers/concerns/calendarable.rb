module Calendarable
  extend ActiveSupport::Concern

  included do
    # before filters and such
  end

  def calendar
    @calendar_res = generate_calendar_reservations
    @resource = generate_calendar_resource
    @src_path = generate_source_path

    # extract calendar data
    respond_to do |format|
      format.html
      format.json
      format.ics {} # render text: Ical.new(@calendar_res).to_ical }
    end
  end

  private

  def generate_calendar_reservations
    fail MethodNotImplemented
  end

  def generate_calendar_resource
    fail MethodNotImplemented
  end

  def generate_source_path
    "calendar_#{@resource.class.to_s.underscore}_path".to_sym
  end
end
