ActiveAdmin.register Person do
  permit_params :first_name, :middle_name, :last_name, :email, :phone, :birthdate, :war_id, :shirt_size_id

  filter :id, as: :numeric, label: 'ID'

  menu priority: 2

  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :middle_name
    column :last_name
    column :phone
    column :created_at
    column :address
    actions
  end

  show do
    attributes_table do
      row :id
      row :first_name
      row :middle_name
      row :last_name
      row :phone
      row :email
      row :birth_date
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :middle_name
      f.input :last_name
      # f.input :address
      f.input :phone
      f.input :email
      f.input :birth_date
      f.input :war
      f.input :shirt_size
    end

    # One way for address
    # f.inputs "Address", for: [:address, f.object.address || Address.new] do |address_form|
    #   address_form.input :street1
    #   address_form.input :street2
    #   address_form.input :city  
    #   address_form.input :state
    #   address_form.input :zipcode

    #   # meta_form.input :description
    #   # meta_form.input :keywords
    # end

    # The other way for address
    f.inputs :name => "Address", for: [:address, f.object.address || Address.new] do |address|
      address.input :street1
      address.input :street2
      address.input :city  
      address.input :state
      address.input :zipcode
    end

    f.inputs "Service Histories", for: :service_histories do |service_history|
      service_history.inputs
    end

    # f.inputs do
    #   f.has_many :service_histories do |b|
    #     b.input :start_year
    #     b.input :end_year
    #     b.input :activity
    #     b.input :story
    #     b.input :branch
    #     b.input :rank
    #     b.input :rank_type
    #   end
    # end
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
