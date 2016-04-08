ActiveAdmin.register MedicalConditionType do
  # actions :all, :except => [:destroy]
  permit_params :name, :description
  # filter :id, as: :numeric, label: 'ID'
  menu parent: "Reference Data"

  config.filters = false

# :nocov:
  csv do
    column :name
    column :description
  end
# :nocov:

  index do
    selectable_column
    actions
    id_column
    column :name
    column :description
    column :created_at
  end

  show do
    attributes_table do
      row :id
      row :name
      row :description
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end


  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :name
      f.input :description
    end
    f.actions
  end


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
