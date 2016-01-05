json.array!(@calendar_res) do |res|
  json.extract! res, :id
  json.title res.reserver.name
  json.start res.start_date
  json.end res.due_date + 1.day
  json.allDay true
  json.url reservation_url(res, format: :html)
end
