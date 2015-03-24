ActiveAdmin.register Flight do
  actions :all, :except => [:destroy]
  permit_params :war_id, :flies_on, :special_instruction, :group_number,
  :tickets_purchased,
    flight_details_attributes: [:id, :airline_id, :flight_number, :departs_at,
    :departs_from, :departure_gate, :destination, :arrives_at, :arrival_gate,
    :_destroy]

  index do
    selectable_column
    column :flies_on
    column :war
    column :tickets_purchased
    column :group_number
    column "People Assigned" do |flight|
      flight.people.count
    end
    column "Airlines" do |flight|
      flight.try(:airline_names)
    end
    actions
  end

  show do
    attributes_table do
      row :war
      row :flies_on
      row :special_instruction
      row :tickets_purchased
      row :group_number
      panel "Flight Details" do
        table_for flight.flight_details do
          column :airline
          column :flight_number
          column :departs_at
          column :departs_from
          column :departure_gate
          column :destination
          column :arrives_at
          column :arrival_gate
          end
        end
      end
    end
      sidebar :flights, :only => :show do
        attributes_table_for resource do
          row("Total on Flight")  { resource.people.count  }
          #row("Dollar Value"){ number_to_currency LineItem.where(:product_id => resource.id).sum(:price) }
        end
      end

  form do |f|
    f.inputs do
      f.input :war
      f.input :flies_on
      f.input :tickets_purchased
      f.input :group_number
      f.input :special_instruction
    end

    panel 'Flight Details' do
      f.has_many :flight_details, label: false do |flight_detail|
        flight_detail.input :id, as: :hidden
        flight_detail.input :airline
        flight_detail.input :flight_number
        flight_detail.input :departs_at, as: :datetime_picker
        flight_detail.input :departs_from
        flight_detail.input :departure_gate
        flight_detail.input :destination
        flight_detail.input :arrives_at, as: :datetime_picker
        flight_detail.input :arrival_gate
        flight_detail.input :_destroy, :as => :boolean, :required => false, :label=>'Remove'
      end
    end

    f.actions do
      f.action :submit
    end
  end
end
