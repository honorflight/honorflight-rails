class SimplePage < ActiveRecord::Base
  validates :key, presence: true
  validates :title, presence: true
  validates :markdown, presence: true

  def html
    redcarpet.render(markdown)
  end

  def as_json(options={})
    super(only: [:id, :key, :title, :markdown], methods: :html)
  end

  private
  def redcarpet
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
  end
end
