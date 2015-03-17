ActiveAdmin.register ContactRelationship do
  permit_params :name, :description
  # filter :id, as: :numeric, label: 'ID'
  menu parent: "Reference Data"

  filter :name
  filter :description
end
