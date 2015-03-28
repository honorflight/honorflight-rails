require 'csv'

RankType.create!([
  {name: "Officer", description: ""},
  {name: "Warrant", description: ""},
  {name: "Enlisted", description: ""}
])

Branch.create!([
  {name: "Army", description: ""},
  {name: "Army Air Corps", description: ""},
  {name: "Marine Corps", description: ""},
  {name: "Navy", description: ""},
  {name: "Air Force", description: ""},
  {name: "Coast Guard", description: ""},
  {name: "Merchant Marine", description: ""}
])

# Import Ranks from CSV - depends RankType, Branch
file = Rails.root.join("db", "csv_imports", "ServiceRanksAll-3_26_2015.csv")
CSV.open(file, headers: true, header_converters: :symbol, converters: :all).each do |rank|
  # Requires a branch
  branch = Branch.where(name: rank[:branch]).first
  rank_type = RankType.where(name: rank[:rank_type]).first
  Rank.create(name: rank[:name], abbreviation: rank[:abbreviation], branch_id: branch.id, rank_type_id: rank_type.id)
end



# Import Awards from CSV - depends Branch
file = Rails.root.join("db", "csv_imports", "ServiceAwardsAll-3_26_2015.csv")
CSV.open(file, headers: true, header_converters: :symbol, converters: :all).each do |award|
  # Requires a branch
  branch = Branch.where(name: award[:branch]).first
  if branch.present?
    Award.create(name: award[:name], description: award[:description], branch_id: branch.id)
  else
    Award.create(name: award[:name], description: award[:description])
  end
end

# Import MedicalConditionTypes from csv
file = Rails.root.join("db", "csv_imports", "medical-condition-types-2015-03-27.csv")
CSV.open(file, headers: true, header_converters: :symbol, converters: :all).each do |mct|
  new_condition = MedicalConditionType.new()
  new_condition.send(:write_attribute, :encrypted_name, MedicalConditionType.encrypt_name(mct[:name]))
  new_condition.save!
end


# Import MedicalConditionNames from CSV - depends types
file = Rails.root.join("db", "csv_imports", "medical-condition-names-2015-03-27.csv")
CSV.open(file, headers: true, header_converters: :symbol, converters: :all).each do |mcn|
  mct = MedicalConditionType.find_by_encrypted_name(MedicalConditionType.encrypt_name(mcn[:medical_condition_type]))
  new_name = MedicalConditionName.new 
  new_name.send(:write_attribute, :encrypted_name, MedicalConditionName.encrypt_name(mcn[:name]))
  new_name.description = mcn[:description]
  new_name.medical_condition_type_id = mct.id
  new_name.save!
end





Airline.create!([
  {name: "Southwest", description: ""}
])
ContactCategory.create!([
  {name: "Alternate", description: ""},
  {name: "Emergency", description: ""},
  {name: "Physician", description: ""}
])
ContactRelationship.create!([
  {name: "Mother", description: ""},
  {name: "Father", description: ""},
  {name: "Son", description: ""},
  {name: "Daughter", description: ""},
  {name: "Niece", description: ""},
  {name: "Nephew", description: ""},
  {name: "Friend", description: ""},
  {name: "Brother", description: ""},
  {name: "Sister", description: ""},
  {name: "Cousin", description: ""},
  {name: "Caregiver", description: ""},
  {name: "Other", description: ""},
  {name: "Grandchild", description: ""}
])
MedicationRoute.create!([
  {name: "Oral", description: ""},
  {name: "Topical", description: ""},
  {name: "Injection", description: ""}
])
MobilityDevice.create!([
  {name: "Walker", description: ""},
  {name: "Cane", description: ""},
  {name: "Scooter", description: ""},
  {name: "Wheelchair", description: ""}
])
PersonStatus.create!([
  {name: "Flight Scheduled", description: nil},
  {name: "Completed", description: nil}
])
ShirtSize.create!([
  {name: "Small", abbreviation: "S", description: ""},
  {name: "Medium", abbreviation: "M", description: ""},
  {name: "Large", abbreviation: "L", description: ""},
  {name: "Extra Large", abbreviation: "XL", description: ""},
  {name: "2 Extra Large", abbreviation: "2XL", description: ""},
  {name: "3 Extra Large", abbreviation: "3XL", description: ""},
  {name: "4 Extra Large", abbreviation: "4XL", description: ""}
])
SimplePage.create!([
  {key: "privacy", title: "Privacy Policy", markdown: "Greater St. Louis Honor Flight will not share your information with anyone outside of Honor Flight."},
  {key: "thank_you", title: "Thank You for Applying", markdown: "Thank you, your application has been successfully submitted.\r\n\r\nPlease be aware that there is a current wait list. Average wait list are: \r\n\r\n1. WWII veteran is 2 months\r\n\r\n1. Korean veteran is 6 to 12 months\r\n\r\n1. Vietnam veteran is 3 years\r\n\r\n**Disclaimer:** *Medical conditions may reduce your wait time.*\r\n\r\nwe love veterans"},
  {key: "veteran_release_info", title: "Consent to Release Information", markdown: "I authorize Honor Flight officials to release my contact information (home phone and address) to other requesting individuals who participate in the same flight for purposes of communication and camaraderie with other participants.\r\n"},
  {key: "terms_conditions", title: "Terms & Conditions", markdown: "# Emergency Situation Statement:\r\n\r\nI hereby authorize Greater St. Louis Honor Flight, Inc. (hereafter, “Honor Flight”), its officers, employees, members, participants, users and/or volunteers, to take the action they believe is appropriate in an emergency situation. Further, I agree to indemnify and hold harmless Honor Flight, any officer, affiliate, employee, member, participant, user and/or volunteer thereof, against any claim's arising out of said emergency care.\r\n\r\n# Agreement Statement:\r\n\r\n1. As photographic and video equipment are frequently used to memorialize and document Honor Flight trips and events, his/her image may appear in a public forum, such as the media or a website, to acknowledge, promote or advance the work of the Honor Flight program. I hereby release the photographer and Honor Flight from all claims and liability relating to said photographs. I hereby give permission for my images captured during Honor Flight activities through video, photo, or other media, to be used solely for the purposes of Honor Flight promotional material and publications, and waive any rights or compensation or ownership thereto.\r\n\r\n2. I further state that medical insurance is my responsibility, and I understand that neither Honor Flight nor the provider of the private aircraft (“Flight Provider”) provides medical care. I understand that I accept all risks associated with travel and other Honor Flight activities and will not hold Honor Flight, the Flight Provider, or any person appearing or quoted in any advertisement or public service announcement for or on behalf of Honor Flight responsible for any injuries incurred by me while participating in Honor Flight activities."}
])
War.create!([
  {name: "Vietnam War", abbreviation: "Vietnam War", begin_year: "1953-01-01", end_year: "1975-01-01"},
  {name: "Korean War", abbreviation: "Korean War", begin_year: "1950-01-01", end_year: "1953-01-01"},
  {name: "World War II", abbreviation: "WWII", begin_year: "1939-01-01", end_year: "1945-01-01"}
])
