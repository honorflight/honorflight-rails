class War < ActiveRecord::Base
	has_many :people

  def with_years(attr)
    self[attr] + " (#{self.begin_year}-#{self.end_year})"
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

	def begin_year
		self[:begin_year].strftime('%Y') unless self[:begin_year].blank?
	end

	def end_year
		self[:end_year].strftime('%Y') unless self[:end_year].blank?
	end

	def begin_year=(year)
		self[:begin_year] = Date.parse("#{year}-01-01")
	end

	def end_year=(year)
		self[:end_year] = Date.parse("#{year}-01-01")
	end

end
