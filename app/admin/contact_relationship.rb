# :nocov:
ActiveAdmin.register ContactRelationship do
  # actions :all, :except => [:destroy]
  permit_params :name, :description
  # filter :id, as: :numeric, label: 'ID'
  menu parent: "Reference Data"

  filter :name
  filter :description

  index do
    selectable_column
    actions
    column :id
    column :name
    column :description
    column :created_at
  end

end
# :nocov: