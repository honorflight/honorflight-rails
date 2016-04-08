ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :first_name, :last_name, :phone, :email_on_event
  menu priority: 98

  filter :first_name
  filter :last_name
  filter :email

  controller do

    def update
      if params[:admin_user][:password].blank?
        params[:admin_user].delete("password")
        params[:admin_user].delete("password_confirmation")
      end
      super
    end

  end


  index do
    selectable_column
    actions
    column :email
    column :first_name
    column :last_name
    column :phone
    column :can_delete
  end

  show do
    attributes_table do
      row :id
      row :name do |me|
        "#{me.try(:first_name)} #{me.try(:last_name)}"
      end
      row :phone
      row :apikey
      row :created_at
      row :can_delete
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :first_name
      f.input :last_name
      f.input :phone
      f.input :email_on_event
    end
    f.actions
  end

end
