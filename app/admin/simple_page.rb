ActiveAdmin.register SimplePage do
  actions :all, :except => [:destroy]
  permit_params :key, :title, :markdown
  menu parent: "Site Settings", priority: 98

  index do
    selectable_column
    actions
    column :id
    column :key
    column :title
    column :created_at
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
