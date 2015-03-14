ActiveAdmin.register Person do
  actions :all, :except => [:destroy]
  permit_params :first_name, :middle_name, :last_name,
    :email, :phone, :birth_date, :war_id, :flight_id, :shirt_size_id,
    :release_info, :tlc, address_attributes: [:street1, :street2, :city,
    :state, :zipcode], medical_conditions_attributes:[:id,
      :medical_condition_type_id, :medical_condition_name_id, :diagnosed_at,
      :diagnosed_last, :description, :_destroy],
    service_histories_attributes:[:id, :start_year, :end_year, :activity, :story,
    :branch_id, :rank_type_id, :rank_id, :_destroy]
  # auto_link war.name

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
    id_column
    column :flight
    column :email
    column :first_name
    column :middle_name
    column :last_name
    column :phone
    column :birth_date
    column :created_at
    column :release_info
    column :tlc
    column :address
    actions
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
      row :tlc
      row :created_at
      row :updated_at
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

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :flight
      f.input :first_name
      f.input :middle_name
      f.input :last_name
      # f.input :address
      f.input :phone
      f.input :email
      f.input :birth_date, as: :date_picker, :order => [:month, :day, :year]
      f.input :war
      f.input :shirt_size
      f.input :tlc
      f.input :release_info
    end

    f.inputs :name => "Address", for: [:address, f.object.address || Address.new] do |address|
      address.input :street1
      address.input :street2
      address.input :city
      address.input :state
      address.input :zipcode
    end

    f.inputs name: 'Emergency Contact', for: [:emergency_contact, f.object.emergency_contact || Contact.new] do |contact|
      contact.input :full_name
      contact.input :phone
      contact.input :email
      contact.input :address, for: [:address, f.object.address || Address.new] do |c|

      end
    end



    panel 'Service Histories' do
      f.has_many :service_histories, label: false do |service_history|
        service_history.input :id, as: :hidden
        service_history.input :start_year
        service_history.input :end_year
        service_history.input :activity
        service_history.input :story
        service_history.input :branch
        service_history.input :rank_type
        service_history.input :rank
        service_history.input :_destroy, :as => :boolean, :required => false, :label=>'Remove'
      end
    end

    panel 'Medical Conditions' do
      f.has_many :medical_conditions, label: false do |medical_condition|
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


  # show do
  #   attributes_table do
  #     row :email
  #     row :phone
  #     row :full_name
  #     row :street1
  #     row :street2
  #     row :city
  #     row :state
  #     row :zip
  #     row :sign_in_count
  #     row :last_sign_in_at
  #     row :trainer
  #     row :confirmed_at
  #   end

  #   active_admin_comments
  # end


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
