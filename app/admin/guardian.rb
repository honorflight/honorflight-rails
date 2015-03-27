ActiveAdmin.register Guardian do
  actions :all, :except => [:destroy]
  permit_params :first_name, :middle_name, :last_name, :Veteran,
    :email, :phone, :birth_date, :application_date, :war_id, :flight_id, :shirt_size_id,
    :release_info, :tlc, :person_status_id, :mobility_device_id, :veteran_id,
    address_attributes: [:id, :street1, :street2, :city,
    :state, :zipcode],
    service_histories_attributes: [:id, :start_year, :end_year, :activity, :story,
      :branch_id, :rank_type_id, :rank_id, :service_awards_id, :_destroy,
        service_awards_attributes: [:id, :award, :award_id, :quantity,
          :comment, :_destroy ]],
    contacts_attributes: [:id, :contact_category_id, :contact_relationship_id,
     :full_name, :email, :phone,
     :alternate_phone, :relationship,
        address_attributes: [:id, :street1, :street2, :city, :state, :zipcode]]

menu parent: "People"


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
    column :veteran
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
    bool_column :applied_online
    #column :address
  end

  show title: :full_name do

    attributes_table do
      row :flight
      row :person_status
      row :first_name
      row :middle_name
      row :last_name
      row(:address) { |person| "#{person.try(:address)}" }
      row :phone
      row :email
      row("Date of Birth"){ |person| person.birth_date }
      row :war
      row :shirt_size
      bool_row :release_info
      row :application_date
      row :updated_at
    end


    panel "Service History" do
      table_for guardian.service_histories do
        column :start_year
        column :end_year
        column :activity
        column :story
        column :branch
        column :rank_type
        column :rank
        column :service_awards do |person| #person.service_awards do |service_awards|
          #val="hi"
          #person.service_awards.each do |service_award|
          #person.service_awards.collect {|sa| sa.award.name}.join(", ")
          person.service_awards.collect {|sa| sa.award.present? ? link_to(sa.award.name, admin_service_award_path(sa)) : "unknown"}.join(", ").html_safe
        end

      end
    end

    panel 'Service Awards' do
      table_for guardian.service_awards do
        column :quantity
        column :comment
        column :award do |service_award|
          service_award.try(:award).try(:name)
        end
      end
    end

    panel "Contacts" do
      table_for guardian.contacts do
        column :contact_category
        column :full_name
        column :email
        column :phone
        column :alternate_phone
        column :contact_relationship
        column :address
      end
    end

    active_admin_comments
  end

  # form partial: 'form'
  form do |f|
    if f.object.address.nil?
      f.object.build_address
    end
    f.semantic_errors *f.object.errors.keys

    f.inputs name: "General" do
      f.input :flight
      f.input :person_status
      f.input :first_name
      f.input :middle_name
      f.input :last_name
      f.semantic_fields_for :address do |a|
        a.input :id, as: :hidden
        a.input :street1
        a.input :street2
        a.input :city
        a.input :state
        a.input :zipcode
      end
      f.input :phone
      f.input :email
      f.input :birth_date,label: "Date of Birth", as: :date_picker, :order => [:month, :day, :year]
      f.input :war
      f.input :application_date
      f.input :shirt_size
      f.input :release_info
    end

    panel 'Service Histories' do
      f.has_many :service_histories, heading: false, allow_destroy: true do |service_history|
        service_history.input :id, as: :hidden
        service_history.inputs :start_year, :end_year, :activity, :story, :branch, :rank_type, :rank
        service_history.has_many :service_awards, allow_destroy: true do |a|
          a.input :id, as: :hidden
          a.inputs :award, :quantity, :comment
        end
      end
    end


    panel "Contacts" do
      f.has_many :contacts, heading: false do |contact|
        if contact.object.address.nil?
          contact.object.build_address
        end
        contact.input :id, as: :hidden
        contact.inputs :contact_category, :full_name, :email, :phone, :alternate_phone, :contact_relationship
        contact.has_many :address, new_record: false, heading: false, allow_destroy: false do |a|
          a.input :id, as: :hidden
          a.inputs :street1, :street2, :city, :state, :zipcode
        end
      end
    end



    f.actions do
      f.action :submit
    end
  end
end
