class War < ActiveRecord::Base
	has_many :people

  def with_years(attr)
    self[attr] + " (#{self.begin_year.strftime('%Y')}-#{self.end_year.strftime('%Y')})"
  end

  def name_with_years
    with_years(:name)
  end

  def abbreviation_with_years
    with_years(:abbreviation)
  end

  def as_json(options={})
    super(only: [:id, :name, :description], methods: [:name_with_years, :abbreviation_with_years])
  end
end
