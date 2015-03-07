class Marshel::Date
  def self.dump(date)
    # if our "date" is already a string, don't try to convert it
    date.is_a?(String) ? date : date.to_s(:db)
  end

  def self.load(date_string)
    Date.parse(date_string)
  end
end