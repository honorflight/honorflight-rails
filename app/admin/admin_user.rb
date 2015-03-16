ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :apikey
  menu priority: 99

  index do
    selectable_column
    id_column
    column :email
    column :apikey
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :email_on_event
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  filter :email_on_event

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :email_on_event
    end
    f.actions
  end

end
