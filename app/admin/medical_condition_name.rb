ActiveAdmin.register MedicalConditionName do
  actions :all, :except => [:destroy]
  permit_params :name, :description, :medical_condition_type_id
  # filter :id, as: :numeric, label: 'ID'
  menu parent: "Reference Data"

  filter :medical_condition_type

  csv do
    column :name
    column :description
    column(:medical_condition_type){|medical_condition_name| medical_condition_name.medical_condition_type.name}
  end

  index do
    selectable_column
    actions
    id_column
    column :name
    column :medical_condition_type
    column :description
    column :created_at
  end

  show do
    attributes_table do
      row :id
      row :medical_condition_type
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
      f.input :medical_condition_type
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
