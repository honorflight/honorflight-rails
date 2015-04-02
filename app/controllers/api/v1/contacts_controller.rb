class API::V1::ContactsController < SessionController
  before_filter :set_person, only: [:create]
  before_filter :set_contact, only: [:update]

  # POST /people/:person_id/contacts
  # POST /people/:person_id/contacts.json
  def create
    @contact =  Contact.create(contact_params)
    if @person.contacts << @contact
      render :json => @contact
    # No invalid routes right now
    # else
    #   render json: @service_history.errors, status: :unprocessable_entity
    end
  end

  # # PATCH/PUT /contacts/1
  # # PATCH/PUT /contacts/1.json
  def update
    if @contact.update_attributes(contact_params)
      render :json => @contact
    # no invalid routes right now
    # else
    #   render json: @service_history.errors, status: :unprocessable_entity
    end

  end

  private
  def set_person
    @person = Person.find(params[:person_id])
  end

  def contact_params
    params.require(:contact).permit(:full_name, :phone, :email, :alternate_phone, :contact_category_id, :contact_relationship_id, address_attributes: [:street1, :city, :state, :zipcode])
      # :first_name, :last_name, :middle_name, :email, :phone, :birth_date, :war_id, :shirt_size_id, address_attributes: [:street1, :city, :state, :zipcode])
  end
  def set_contact
    @contact ||= Contact.find(params[:id])
  end
end
