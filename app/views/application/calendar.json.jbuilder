# colors (currently "borrowed" from Bootstrap)
overdue_color = '#d9534f'
reserved_color = '#337ab7'
checked_out_color = '#5bc0de'
returned_color = '#5cb85c'
missed_color = '#888'

# generate json
json.array!(@calendar_res) do |res|
  json.extract! res, :id
  json.title res.reserver.name
  json.start res.start_date
  # if overdue, make it end today and color it red
  if res.overdue
    if res.returned?
      json.end res.checked_in + 1.day
    else
      json.end Time.zone.today + 1.day
    end
    json.backgroundColor overdue_color
  # otherwise, color by status and set end date appropriately
  else
    if res.returned?
      json.end res.checked_in + 1.day
    else
      json.end res.due_date + 1.day
    end
    json.backgroundColor eval("#{res.status}_color")
  end
  json.allDay true
  json.url reservation_url(res, format: :html)
  json.hasItem !res.equipment_item.nil?
  json.location res.equipment_item.name unless res.equipment_item.nil?
end
