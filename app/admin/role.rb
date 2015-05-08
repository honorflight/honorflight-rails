ActiveAdmin.register Role do
  actions :all, :except => [:destroy]
  permit_params :name, :description, :short_code

  filter :name
  filter :description


  menu parent: "Reference Data", label: "Volunteer Roles"

  index do
    selectable_column
    actions
    column :id
    column :name
    column :description
    column :created_at
  end

  show do
    attributes_table  do
      row :name
      row :description
      row :short_code
      table_for role.flight_responsibilities, heading: false  do

        column "Flight Responsibilities", :name
      end
    end
    active_admin_comments
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
