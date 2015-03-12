ActiveAdmin.register Rank do
  permit_params :name, :description, :rank_type_id, :branch_id
  # filter :id, as: :numeric, label: 'ID'
  menu parent: "Reference Data"

  filter :rank_type
  filter :name
  filter :description


  index do
    selectable_column
    id_column
    column :name
    column :branch do |b|
      b.branch.name
    end
    column :rank_type do |b|
      b.rank_type.name
    end
    column :created_at
    column :updated_at
    actions
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
