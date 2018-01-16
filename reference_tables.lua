function table_with_name(tab_name)
  if tab_name == 'unisex_names' then
    return unisex_names
  elseif tab_name == 'last_names' then
    return last_names
  elseif tab_name == 'home_towns' then
    return home_towns
  end
end

unisex_names = {
  "Chris",
  "Pat",
  "Dee",
  "Lee",
  "Robin",
  "Drew",
  "Casey",
  "Tracy",
  "Wallace"
}

last_names = {
  "Smith",
  "Roberts",
  "Daniels",
  "Johnson",
  "Whitney",
  "Michaels",
  "Lopez",
  "Clark",
  "Davis"
}

home_towns = {
  "Asheville",
  "Garner",
  "Middlebury",
  "Springfield",
  "Raleigh",
  "Beaufort",
  "Las Vegas",
  "Los Angeles",
  "San Francisco",
  "Boston",
  "Richmond"
}
