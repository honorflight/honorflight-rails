ActiveAdmin.register MedicalConditionName do
  permit_params :name, :description, :medical_condition_type_id
  filter :id, as: :numeric, label: 'ID'
  menu parent: "Reference Data"


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
