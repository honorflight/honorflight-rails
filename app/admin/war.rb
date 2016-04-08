ActiveAdmin.register War do
  permit_params :name, :abbreviation, :begin_year, :end_year

  menu parent: "Reference Data"

# :nocov:
  filter :name
  filter :abbreviation
  filter :begin_year
  filter :end_year
# :nocov:

  index do
    selectable_column
    actions
    column :name
    column :abbreviation
    column :begin_year
    column :end_year
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :abbreviation
      f.input :begin_year, as: :select, collection: 1935...2000
      f.input :end_year, as: :select, collection: 1935...2000
    end

    f.actions
  end




  # filter :id, as: :numeric, label: 'ID'

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
