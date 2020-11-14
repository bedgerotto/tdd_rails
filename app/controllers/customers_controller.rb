class CustomersController < ApplicationController
  def index
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(permitted_params)

    if @customer.save
      redirect_to customers_path, notice: 'Customer Succesfully Stored'
    else
      render :new
    end
  end

  private

  def permitted_params
    params.require(:customer).permit(:name, :email, :phone, :smoker, :avatar)
  end
end
