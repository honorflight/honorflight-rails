ActiveAdmin.register Award do
  permit_params :name, :description, :branch_id
  # filter :id, as: :numeric, label: 'ID'
  menu parent: "Reference Data"


  filter :branch
  filter :name
  filter :description
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
