ActiveAdmin.register DayOfFlight do
  actions :all, :except => [:destroy]
  permit_params :war_id, :flies_on, :special_instruction, :group_number,
    :tickets_purchased,
    flight_details_attributes: [:id, :airline_id, :flight_number, :departs_at,
    :departs_from, :departure_gate, :destination, :arrives_at, :arrival_gate,
    :_destroy],
    day_of_flights_volunteers_attributes:[:id,
      :person_id, :flight_responsibility_id, :_destroy],
    flight_attachments_attributes: [:id, :name, :comments, :day_of_flight_id, :attachment, 
      :_destroy]

  # Remove All filters except War, Special Instructions, Airline

# :nocov:
  filter :war
  filter :special_instruction
  filter :airline
# :nocov:

  index do
    selectable_column
    actions
    column :flies_on
    column :war
    column :tickets_purchased
    column :group_number
    column "People Assigned" do |flight|
      flight.people_count
    end
    column "Airlines" do |flight|
      flight.try(:airline_names)
    end
  end

  show do
    attributes_table do
      row :war
      row :flies_on
      row :special_instruction
      row :tickets_purchased
      row :group_number

      panel "Flight Responsabilities" do
        table_for day_of_flight.day_of_flights_volunteers do
          column :flight_responsibility
          column :volunteer

        end
      end

      panel "Veterans" do
        table_for day_of_flight.veterans do
          column(:full_name) { |o| link_to(o.full_name, admin_veteran_path(o))}
          column(:guardian) { |o| link_to(o.guardian.full_name, admin_guardian_path(o.guardian))}
        end
      end

      panel "Flight Details" do
        table_for day_of_flight.flight_details do
          column :airline
          column :flight_number
          column "Departs On", :departs_at
          column :departs_from
          column :departure_gate
          column :destination
          column "Arrives On", :arrives_at
          column :arrival_gate
          end
        end
      end

      panel "Attachments" do
      table_for day_of_flight.flight_attachments do 
        column :name
        column :comments
        column :attachment do |attachment|
          unless attachment.nil?
            link_to(attachment.attachment.file.try(:basename), attachment.attachment_url, target: "_blank")
          end
        end
      end
    end


    end

    sidebar :flights, :only => :show do
      attributes_table_for resource do
        row("Total on Flight")  { resource.people_count  }
        #row("Dollar Value"){ number_to_currency LineItem.where(:product_id => resource.id).sum(:price) }
      end
    end

  form do |f|
    f.inputs do
      f.input :war
      f.input :flies_on, as: :date_picker, :order => [:month, :day, :year]
      f.input :tickets_purchased
      f.input :group_number
      f.input :special_instruction
    end

    panel 'Flight Volunteers' do
      f.has_many :day_of_flights_volunteers, heading: false, allow_destroy: true do |volunteer|
        volunteer.input :flight_responsibility, input_html: { class: "flight_responsibility_type_dd" }
        volunteer.input :volunteer, input_html: { class: "volunteer_type_dd" }
      end
    end

    panel 'Flight Details' do
      f.has_many :flight_details, heading: false  do |flight_detail|
        flight_detail.input :id, as: :hidden
        flight_detail.input :airline
        flight_detail.input :flight_number
        flight_detail.input :departs_at, label: "Departs On", as: :datetime_picker
        flight_detail.input :departs_from
        flight_detail.input :departure_gate
        flight_detail.input :destination
        flight_detail.input :arrives_at, label: "Arrive On", as: :datetime_picker
        flight_detail.input :arrival_gate
        flight_detail.input :_destroy, :as => :boolean, :required => false, :label=>'Remove'
      end
    end

    panel "Attachments" do
      f.has_many :flight_attachments,  heading: false, allow_destroy: true do |attachment|
        attachment.input :day_of_flight_id, as: :hidden
        attachment.input :attachment, as: :file
        attachment.input :name
        attachment.input :comments
      end
    end

    f.actions do
      f.action :submit
    end
  end
end
