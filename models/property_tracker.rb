require('pg')

class Property
  attr_accessor :address, :value, :number_of_bedrooms, :year_built
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @address = options['address']
    @value = options['value'].to_i
    @number_of_bedrooms = options['number_of_bedrooms']
    @year_built = options['year_built']
  end

  def save()
    db = PG.connect({dbname: "properties", host: "localhost"})

    sql = "INSERT INTO properties
    (address, value, number_of_bedrooms, year_built)
    VALUES ($1, $2, $3, $4)
    RETURNING *"
    values = [@address, @value, @number_of_bedrooms, @year_built]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def Property.delete_all()
    db= PG.connect({dbname:"properties", host:"localhost"})
    sql = "DELETE FROM properties"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close
  end

  def delete()
    db = PG.connect({dbname:"properties", host: "localhost"})
    sql = "DELETE FROM properties WHERE id = $1"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close()
  end

  def update()
    db = PG.connect({dbname:"properties", host: "localhost"})
    sql = "UPDATE properties SET (address, value, number_of_bedrooms, year_built)
    = ($1, $2, $3, $4)
    WHERE id = $5"
    values = [@address, @value, @number_of_bedrooms, @year_built, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def Property.all()
    db = PG.connect({dbname: "properties", host: "localhost"})
    sql = "SELECT * FROM properties"
    db.prepare("all", sql)
    all_properties = db.exec_prepared("all")
    db.close
    return all_properties.map{|all_properties_hash| Property.new (all_properties_hash)}
  end


  def Property.find_by_id(id)
    db = PG.connect({dbname:"properties", host: "localhost"})
    sql = "SELECT * FROM properties WHERE id = $1"
    values = [id]
    db.prepare("find", sql)
    found_property = db.exec_prepared("find", values)
    return Property.new(found_property[0])
  end

  def Property.find_by_address(address)
    db = PG.connect({dbname:"properties", host:"localhost"})
    sql = "SELECT * FROM properties WHERE address = $1"
    values = [address]
    db.prepare("found", sql)
    found_property_address = db.exec_prepared("found", values)
    return Property.new(found_property_address[0])
  end

end
