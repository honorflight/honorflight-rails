ActiveAdmin.register SmtpSetting do
  # actions :edit, :show, :update
  menu parent: "Site Settings", priority: 99
  permit_params :id
  config.filters = false
  config.batch_actions = false

  controller do
    def resource
      SmtpSetting.first
    end

    def update
      if params[:smtp_setting][:password].blank?
        params[:smtp_setting].delete("password")
        params[:smtp_setting].delete("password_confirmation")
      end
      super
    end

    def find_resource
      if request.fullpath == "/admin/smtp_settings"
        SmtpSetting.first
      else
        super
      end
    end
  end

  index do
    selectable_column
    id_column
    column :from_name
    column :smtp_server
    column :username
    actions
  end

  show do
    attributes_table do
      row :from_name
      row :smtp_server
      row :port
      row :authentication
      row :username
      row :openssl_verify_mode
      row :enable_starttls_auto
    end
    active_admin_comments
  end


  form do |f|
    f.inputs do
      f.input :from_name, :hint => "This will replace the (Email Name) <...> portion of the 'From' in new emails"
      f.input :smtp_server, hint: "smtp.gmail.com"
      f.input :port, hint: "465 for SSL, 587 for open tls"
      f.input :authentication, hint: "plain for TLS"
      f.input :username, hint: "Login email address"
      f.input :password
      f.input :openssl_verify_mode, hint: "Set to 'none', unless you know better. Gmail port is 465 for this option, ymmv"
      f.input :enable_starttls_auto, hint: "This value should be checked. (either this or open ssl is required). Gmail Port is 587 for this option."
    end
    f.actions do
      f.action :submit
    end
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
