ActiveAdmin.register Guardian do
  # actions :all, :except => [:destroy]
  permit_params :first_name, :middle_name, :last_name, :Veteran,
    :email, :phone, :birth_date, :application_date, :war_id, :day_of_flight_id, :shirt_size_id,
    :special_request, :cell_phone, :work_phone, :work_email,
    :release_info, :tlc, :person_status_id, :mobility_device_id, :guardian_id, :name_suffix_id,
    :learned_about, :why_volunteer, :previous_experience,
    address_attributes: [:id, :street1, :street2, :city,
    :state, :zipcode],
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

  menu parent: "People", priority: 3

# :nocov:
  filter :war
  # filter :flight_id_blank, label: "Never Flown", as: :boolean
  # filter :day_of_flight, collection: -> { DayOfFlight.all.collect(){|f| [f.flies_on.to_s(:long), f.id]}.insert(0,["None", "nil"]) }
  filter :day_of_flight, collection: -> { DayOfFlight.order(flies_on: :desc).collect(){|f| [f.flies_on.to_s(:long), f.id]}.insert(0,["None", "nil"]) }
  filter :shirt_size
  filter :first_name
  filter :last_name
  filter :middle_name
  filter :person_status
  filter :created_at
  filter :release_info
# :nocov:

# :nocov:
  controller do
    def index # This is for catching the Day Of Flight filter.
      if params[:q].present? && params[:q][:day_of_flight_id_eq]=="nil"
        params[:q][:day_of_flight_id_null]=true
        params[:q].delete(:day_of_flight_id_eq)
      end

      super

      if params[:q].present? && params[:q][:day_of_flight_id_null]==true
        params[:q][:day_of_flight_id_eq]="nil"
        params[:q].delete(:day_of_flight_id_null)
      end     
    end
  end
# :nocov:

# :nocov:
  csv do
    column :id
    column(:person_status) { |person| person.try(:person_status).try(:name) }
    column(:veteran) { |person| person.try(:veteran).try(:full_name) }
    column :email
    column :full_name
    column :first_name
    column :middle_name
    column :last_name
    column :name_suffix
    column :cell_phone
    column :phone
    column(:birth_date)
    column(:shirt_size) { |person| person.try(:shirt_size).try(:name)}
    column :created_at
    column :release_info
    column :tlc
    column :applied_online
    column :application_date
    column(:address){ |person| person.try(:address) }
    column(:street1) { |person| person.try(:address).try(:street1) }
    column(:street2) { |person| person.try(:address).try(:street2) }
    column(:city) { |person| person.try(:address).try(:city) }
    column(:state) { |person| person.try(:address).try(:state) }
    column(:zipcode) { |person| person.try(:address).try(:zipcode) }
    # column(:address)
  end
# :nocov:

  index do
    selectable_column
    actions
    column(:person_status) { |person| person.try(:person_status).try(:name) }
    column :veteran do |person|
      begin
        link_to(person.try(:veteran).try(:full_name), admin_veteran_path(person.try(:veteran).try(:id)))
      rescue
      end
    end
    #column :email
    column :day_of_flight
    column :first_name
    column :middle_name
    column :last_name
    #column :phone
    column "Date of Birth", :birth_date
    column :age
    column :application_date
    bool_column :release_info
    bool_column "TLC", :tlc
    bool_column :applied_online
    #column :address
  end

  show title: :full_name do

    attributes_table do
      row(:veteran) {|person| person.try(:veteran)}
      row(:person_status) { |person| person.try(:person_status).try(:name) }
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
      row("Date of Birth"){ |person| person.birth_date }
      row :age
      row :war
      row :shirt_size
      row :special_request
      bool_row :release_info
      row ("How did you learn about us?"){ |person| person.learned_about }
      row ("Why did you decide you want to volunteer for us?") { |person| person.why_volunteer }
      row ("Please list any previous volunteer experience:") { |person| person.previous_experience }
      row :application_date
      row :updated_at
    end


    panel "Service History" do
      table_for guardian.service_histories do
        column :branch
        column :start_year
        column :end_year
        column :rank_type
        column :rank
        column :activity
        column :story
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
    panel "Attachments" do
      table_for guardian.people_attachments do
        column :name
        column :comments
        column :attachment do |attachment|
          unless attachment.attachment.file.blank?
            link_to(attachment.attachment.file.try(:basename) || attachment.attachment.file.try(:path).try(:split, "/").try(:last), attachment.attachment_url, target: "_blank")
          end
        end
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

    f.actions

    f.inputs name: "General" do
      if !f.object.new_record?
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
      f.input :shirt_size
      f.input :special_request
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
    f.inputs do
      f.input :learned_about, label: "How did you learn about us?"
      f.input :why_volunteer, label: "Why did you decide you want to volunteer for us?"
      f.input :previous_experience, label: "Please list any previous volunteer experience:"
    end
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
