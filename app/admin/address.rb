# :nocov:
ActiveAdmin.register Address do
  actions :all, :except => [:destroy]
  permit_params :street1, :street2, :city, :state, :zipcode, :person_id, :contact_id
  menu false

  show do
    attributes_table do
      row :id, as: :hidden
      row :person
      row :street1
      row :street2
      row :city
      row :state
      row :zipcode
    end
  end

end
# :nocov:
