ActiveAdmin.register War do
  permit_params :name, :abbreviation

  menu parent: "Reference Data"

  filter :war_id,
    collection: -> { Person.all() },
    label:      'War'

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
