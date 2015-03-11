ActiveAdmin.register MedicalConditionName do
  permit_params :name, :description, :medical_condition_type_id
  # filter :id, as: :numeric, label: 'ID'
  menu parent: "Reference Data"

  filter :medical_condition_type

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :created_at
    column :medical_condition_type
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :description
      row :medical_condition_type
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
      f.input :medical_condition_type
    end
    f.actions do
      f.action :submit
    end
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
