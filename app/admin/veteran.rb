ActiveAdmin.register Veteran do
  actions :all, :except => [:destroy]
  permit_params :first_name, :middle_name, :last_name, :Veteran,
    :email, :phone, :birth_date, :application_date, :war_id, :day_of_flight_id, :shirt_size_id,
    :cell_phone, :work_phone, :work_email, :special_request,
    :release_info, :tlc, :person_status_id, :mobility_device_id, :guardian_id, :name_suffix_id,
    address_attributes: [:id, :street1, :street2, :city, :state, :zipcode],
    travel_companions_attributes: [:id, :travel_companion_id, :_destroy],
    medications_attributes: [:id, :medication, :dose, :frequency, :route, :medication_route_id],
    medical_allergies_attributes: [:id, :medical_allergy],
    medical_conditions_attributes: [:id,
      :medical_condition_type_id, :medical_condition_name_id, 
      :last_occurrence, :comment, :_destroy],
    service_histories_attributes: [:id, :start_year, :end_year, :activity, :story,
      :branch_id, :rank_type_id, :rank_id, :service_awards_id, :_destroy,
        service_awards_attributes: [:id, :award, :award_id, :quantity,
          :comment, :_destroy ]],
    contacts_attributes: [:id, :contact_category_id, :contact_relationship_id,
     :full_name, :email, :phone,
     :alternate_phone, :relationship,
        address_attributes: [:id, :street1, :street2, :city, :state, :zipcode]],
    people_attachments_attributes: [:id, :name, :comments, :person_id, :attachment, 
      :_destroy]

  menu parent: "People", priority: 2

# :nocov:
  filter :war
  # filter :flight_id_blank, label: "Never Flown", as: :boolean
  filter :day_of_flight, collection: -> { DayOfFlight.all.collect(){|f| [f.flies_on.to_s(:long), f.id]}.insert(0,["None", "nil"]) }
  filter :shirt_size
  filter :first_name
  filter :last_name
  filter :middle_name
  filter :person_status
  filter :created_at
  filter :release_info
  filter :tlc
# :nocov:

# :nocov:
  controller do
    def index
      if params[:q].present? && params[:q][:day_of_flight_id_eq]=="nil"
        params[:q][:day_of_flight_id_null]=true
        params[:q].delete(:day_of_flight_id_eq)
      end
      super
    end

    # def update
    #   binding.remote_pry
    #   super
    # end
  end
# :nocov:

# :nocov:
  csv do
    column :id
    column(:day_of_flight) { |person| person.try(:day_of_flight, :flies_on) }
    column(:person_status) { |person| person.try(:person_status).try(:name) }
    column(:guardian) { |person| person.try(:guardian).try(:full_name) }
    column :email
    column :full_name
    column :first_name
    column :middle_name
    column :last_name
    column :name_suffix
    column :phone
    column :cell_phone
    column :work_phone
    column ("Date of Birth"){ |person| person.birth_date }
    column :created_at
    column :release_info
    column :tlc
    column :applied_online
    column :application_date
    column(:address){ |person| person.try(:address) }
    # column(:address)
  end
# :nocov:


  index do
    selectable_column
    actions
    column(:day_of_flight)
    column :person_status
    column :guardian do |person|
      begin
        link_to(person.try(:guardian).try(:full_name), admin_guardian_path(person.try(:guardian).try(:id)))
      rescue
      end
    end
    #column :email
    column :first_name
    column :middle_name
    column :last_name
    #column :phone
    column("Date of Birth"){ |person| person.birth_date.to_s(:aa)}
    column(:application_date) { |p| p.application_date.to_s(:aa)}
    bool_column :release_info
    bool_column "TLC", :tlc
    bool_column :applied_online
    #column :address
  end

  show title: :full_name do

    attributes_table do
      row :day_of_flight
      row :guardian
      row :person_status
      row :first_name
      row :middle_name
      row :last_name
      row :name_suffix
      row(:address) { |person| "#{person.try(:address)}" }
      row :phone
      row :cell_phone
      row :work_phone
      row :email
      row :work_email
      row("Date of Birth"){ |person| person.birth_date.to_s(:aa) }
      row :war
      row :shirt_size
      row :special_request
      # panel "Travel Companion" do
      #   table_for veteran.travel_companions do
      #     column("Travel Companion") { |travel_companion| travel_companions.try(:travel_companion).try(:veteran) }
      #   end
      # end
      bool_row :release_info
      bool_row "TLC", :tlc
      row :application_date
      row ("Update At") { |person| person.updated_at }
    end


    panel "Service History" do
      table_for veteran.service_histories do
        column :branch
        column :start_year
        column :end_year
        column :rank_type
        column :rank        
        column :activity
        column :story
        column :service_awards do |person| #person.service_awards do |service_awards|
          person.service_awards.collect {|sa| sa.award.present? ? link_to(sa.award.name, admin_service_award_path(sa)) : "unknown"}.join(", ").html_safe
        end

      end
    end

    panel 'Service Awards' do
      table_for veteran.service_awards do
        column :quantity
        column :comment
        column :award do |service_award|
          service_award.try(:award).try(:name)
        end
      end
    end

    panel "Contacts" do
      table_for veteran.contacts do
        column :contact_category
        column :full_name
        column :email
        column :phone
        column :alternate_phone
        column :contact_relationship
        column :address
      end
    end

    panel "Medical Concerns" do
      attributes_table_for resource.mobility_device do
        row("Mobility Device") { resource.try(:mobility_device, :name) }
      end

      panel "Medical Conditions" do
        table_for veteran.medical_conditions do
          column("Condition Type") { |condition| condition.try(:medical_condition_type).try(:name) }
          column("Condition Name") { |condition| condition.try(:medical_condition_name).try(:name) }
          column :last_occurrence
          column("Comments") { |condition| condition.comment }
        end
      end
      # panel "Medications" do
      #   table_for veteran.medications do
      #     column :medication
      #     column :dose
      #     column :frequency
      #     column :medication_route
      #
      #     table_for veteran.medical_allergies do
      #       column :medical_allergy
      #     end
      #   end
      # end
    end

    panel "Travel Companion" do
      table_for veteran.travel_companions do
        column("Travel Companion") do |travel_companion| 
          if travel_companion.travel_companion_id.present?
            Veteran.find(travel_companion.travel_companion_id).full_name
          else
            nil
          end
        end
      end
    end

    panel "Attachments" do
      table_for veteran.people_attachments do 
        column :name
        column :comments
        column :attachment do |attachment|
          # binding.remote_pry
          unless attachment.attachment.file.blank?
            link_to(attachment.attachment.file.try(:basename) || attachment.attachment.file.try(:path).try(:split, "/").try(:last), attachment.attachment_url, target: "_blank")
          end
        end
      end
    end


    active_admin_comments
  end

  # form partial: 'form'
  form(:html => { :multipart => true }) do |f|
    if f.object.address.nil?
      f.object.build_address
    end
    f.semantic_errors *f.object.errors.keys

    f.actions 

    #binding.remote_pry
    f.inputs name: "General" do
      if !f.object.new_record?
        f.input :day_of_flight
        f.input :guardian
        f.input :person_status
      end
      f.input :last_name
      f.input :first_name
      f.input :middle_name
      f.input :name_suffix
      f.semantic_fields_for :address do |a|
        a.input :id, as: :hidden
        a.input :street1
        a.input :street2
        a.input :city
        a.input :state
        a.input :zipcode
      end
      f.input :phone
      f.input :cell_phone
      f.input :work_phone
      f.input :email
      f.input :work_email
      f.input :birth_date,label: "Date of Birth", as: :date_picker, :order => [:month, :day, :year]
      f.input :war
      f.input :application_date,label: "Application date", as: :date_picker, :order => [:month, :day, :year]
      #f.input :application_date
      f.input :shirt_size
      f.input :special_request
      f.input :tlc, label: "TLC"
      f.input :release_info
    end

    panel 'Service Histories' do
      f.has_many :service_histories, heading: false, allow_destroy: true do |service_history|
        service_history.input :id, as: :hidden
        service_history.input :branch, input_html: {class: "branch_dd"}
        service_history.inputs :start_year, :end_year
        service_history.input :rank_type, input_html: {class: "rank_type_dd"}
        service_history.input :rank, input_html: {class: "rank_dd"}       
        service_history.inputs :activity, :story
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

    panel 'Medical Concerns' do
      f.inputs :mobility_device
      panel 'Medical Conditions' do
        f.has_many :medical_conditions, heading: false, allow_destroy: true do |medical_condition|
          medical_condition.input :id, as: :hidden
          medical_condition.input :medical_condition_type, label: "Condition Type", input_html: { class: "medical_condition_type_dd" }
          medical_condition.input :medical_condition_name, label: "Condition Name", input_html: { class: "medical_condition_name_dd" }
          medical_condition.input :last_occurrence, label: "Last Occurrence", as: :date_picker, :order => [:month, :day, :year]
          medical_condition.input :comment
        end
      end
      panel 'Medical Allergies' do
        f.has_many :medical_allergies, heading: false, allow_destroy: true do |medical_allergy|
          medical_allergy.input :id, as: :hidden
          medical_allergy.input :medical_allergy
        end
      end
    end
    panel 'Travel Companion' do
        f.has_many :travel_companions, heading: false, allow_destroy: true do |travel_companion|
          travel_companion.input :id, as: :hidden
          travel_companion.input :travel_companion_id, label: 'Travel Companion', as: :select, collection: Veteran.all.map{|v| ["#{v.last_name}, #{v.first_name}", v.id]}
      end
    end
    # panel 'Medications' do
    #   f.has_many :medications, heading: false, allow_destroy: true do |medication|
    #     medication.input :id, as: :hidden
    #     medication.input :medication
    #     medication.input :dose
    #     medication.input :frequency
    #     medication.input :medication_route
    #   end
    # end
    panel "Attachments" do
      f.has_many :people_attachments,  heading: false, allow_destroy: true do |attachment|
        attachment.input :person_id, as: :hidden
        attachment.input :attachment, as: :file
        attachment.input :name
        attachment.input :comments
      end
    end

    f.actions
  end
end
