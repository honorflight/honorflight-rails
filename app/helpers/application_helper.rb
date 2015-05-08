module ApplicationHelper
	def formatDate(date)
	  date.strftime("%m/%d/%Y")
	end 

	def formatDateTime(date)
	  date.strftime("%m/%d/%Y %H:%M:%S")
	end

	def wash_phone(p)
    p.gsub!(/\s?x.*$/, "")
    p.gsub!(/[^0-9]*/, "")
    p.gsub!(/^1/, "") if p.length == 11
    p
  end
end
