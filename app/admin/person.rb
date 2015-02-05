ActiveAdmin.register Person do
  permit_params :first_name, :middle_name, :last_name, :email, :phone, :birthdate

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
