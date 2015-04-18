Role.create!([
  {name: "Flight Leader"},
  {name: "EMT"},
  {name: "Photographer"},
  {name: "Nurse"}
])

flight_leader = Role.where(name: "Flight Leader").first
emt = Role.where(name: "EMT").first
nurse = Role.where(name: "Nurse").first
camera = Role.where(name: "Photographer").first

FlightResponsibility.create!([
  {name: "Flight Leader 1", role: flight_leader},
  {name: "Flight Leader 2", role: flight_leader},
  {name: "Flight Leader 3", role: flight_leader},
  {name: "Flight Leader 4", role: flight_leader},
  {name: "Flight Leader 5", role: flight_leader},
  {name: "EMT", role: emt},
  {name: "Nurse", role: nurse},
  {name: "Photographer", role: camera}
])