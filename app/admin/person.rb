ActiveAdmin.register Person do
  actions :all, :except => [:destroy]
  permit_params :first_name, :middle_name, :last_name,
    :email, :phone, :birth_date, :war_id, :flight_id, :shirt_size_id,
    :release_info, :tlc, address_attributes: [:id, :street1, :street2, :city,
    :state, :zipcode], medical_conditions_attributes:[:id,
      :medical_condition_type_id, :medical_condition_name_id, :diagnosed_at,
      :diagnosed_last, :description, :_destroy],
    service_histories_attributes: [:id, :start_year, :end_year, :activity, :story,
    :branch_id, :rank_type_id, :rank_id, :_destroy],
    contacts_attributes: [:id, :contact_category_id, :contact_relationship_id, :full_name, :email, :phone,
     :alternate_phone, :relationship, address_attributes: [:id, :street1,
     :street2, :city, :state, :zipcode]]


  filter :war
  filter :flight
  filter :shirt_size
  filter :first_name
  filter :last_name
  filter :middle_name
  filter :created_at
  filter :release_info

  menu priority: 2

  index do
    selectable_column
    actions
    column :flight
    column :email
    column :first_name
    column :middle_name
    column :last_name
    column :phone
    column :birth_date
    column :created_at
    column :release_info
    column "TLC", :tlc
    column :address
  end

  show do

    attributes_table do
      row :id
      row :flight
      row :first_name
      row :middle_name
      row :last_name
      row :address
      row :phone
      row :email
      row :birth_date
      row :release_info
      row "TLC", :tlc
      row :created_at
      row :updated_at
      panel "Contacts" do
        table_for person.contacts do
        column :contact_category
        column :full_name
        column :email
        column :phone
        column :alternate_phone
        column :contact_relationship
        column :address
        end
      end

      panel "Service History" do
        table_for person.service_histories do
          column :start_year
          column :end_year
          column :activity
          column :story
          column :branch
          column :rank_type
          column :rank
        end
      end
      panel "Medical Conditions" do
        table_for person.medical_conditions do
            column :medical_condition_type
            column :medical_condition_name
            column :diagnosed_at
            column :diagnosed_last
            column :description
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

    f.inputs name: "General" do
      f.input :flight
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
      f.input :birth_date, as: :date_picker, :order => [:month, :day, :year]
      f.input :war
      f.input :shirt_size
      f.input :tlc
      f.input :release_info
    end

    panel "Contacts" do
      f.has_many :contacts, heading: false do |contact|
        if contact.object.address.nil?
          contact.object.build_address
        end
        contact.input :id, as: :hidden
        contact.inputs :contact_category, :full_name, :email, :phone, :alternate_phone, :contact_relationship
        contact.has_many :address, new_record: false, heading: false do |a|
          a.input :id, as: :hidden
          a.inputs :street1, :street2, :city, :state, :zipcode
        end
      end
    end

    panel 'Service Histories' do
      f.has_many :service_histories, heading: false, allow_destroy: true do |service_history|
        service_history.input :id, as: :hidden
        service_history.inputs :start_year, :end_year, :activity, :story, :branch, :rank_type, :rank
      end
    end

    panel 'Medical Conditions' do
      f.has_many :medical_conditions, heading: false, allow_destroy: true do |medical_condition|
        medical_condition.input :id, as: :hidden
        medical_condition.input :medical_condition_type
        medical_condition.input :medical_condition_name
        medical_condition.input :diagnosed_at
        medical_condition.input :diagnosed_last
        medical_condition.input :description
        medical_condition.input :_destroy, :as => :boolean, :required => false, :label=>'Remove'
      end
    end


    f.actions do
      f.action :submit
    end
  end
end
