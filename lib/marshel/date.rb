class Marshel::Date
  def self.valid_date?(date_string)
    begin
      return Date.parse(date_string)
    rescue
    end

    begin
      return Date.strptime(date_string, "%m/%d/%Y")
    rescue
    end
    nil
  end

  def self.dump(date)
    if date.is_a?(String)
      return date if valid_date?(date)
    end

    if date.is_a?(Date)
      return date.to_s(:db)
    end
    
    nil
  end

  def self.load(date_string)
    valid_date?(date_string)
  end
end