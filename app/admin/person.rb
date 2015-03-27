ActiveAdmin.register Person do
  actions :none
  config.batch_actions = false

  filter :war
  # filter :flight_id_blank, label: "Never Flown", as: :boolean
  filter :flight, collection: -> { Flight.all.collect(){|f| [f.flies_on.to_s(:long), f.id]}.insert(0,["None", "nil"]) }
  filter :shirt_size
  filter :first_name
  filter :last_name
  filter :middle_name
  filter :person_status
  filter :created_at
  filter :release_info
  filter :tlc

  menu priority: 2

  controller do
    def index
      if params[:q].present? && params[:q][:flight_id_eq]=="nil"
        params[:q][:flight_id_null]=true
        params[:q].delete(:flight_id_eq)
      end
      super
    end
  end

  csv do
    column :id
    column :type
    column(:flight) { |person| person.try(:flight, :flies_on) }
    column(:person_status) { |person| person.try(:person_status).try(:name) }
    column :email
    column :full_name
    column :first_name
    column :middle_name
    column :last_name
    column :phone
    column (:birth_date)
    column :created_at
    column :release_info
    column :tlc
    column :applied_online
    column :application_date
    column(:address){ |person| person.try(:address) }
    # column(:address)
  end

  index do
    selectable_column
    actions
    column :flight
    column :person_status
    #column :email
    column :first_name
    column :middle_name
    column :last_name
    #column :phone
    column "Date of Birth", :birth_date
    column :application_date
    bool_column :release_info
    bool_column "TLC", :tlc
    column (:veteran)     {|person| status_tag(person.type) }
    bool_column :applied_online
    #column :address
  end
end
