require('pry')
require_relative('./models/property_tracker')

Property.delete_all()

property1 = Property.new(
  'address' => '1 Elm Street',
  'value' => 300,
  'number_of_bedrooms' => '4',
  'year_built' => '1666'
)

property2 = Property.new(
  'address' => '221 Baker Street',
  'value' => 212,
  'number_of_bedrooms' => '2',
  'year_built' => '1876'
)

property3 = Property.new(
  'address' => '505 Old Yellow Brick',
  'value' => 505,
  'number_of_bedrooms' => '3',
  'year_built' => '2007'
)
property1.save()
property2.save()
property3.save()

# property1.delete()
property2.value = '200'
property2.update()
properties = Property.all()



found_by_id_property = Property.find_by_id(property1.id)
found_by_address = Property.find_by_address(property1.address)
binding.pry
nil
