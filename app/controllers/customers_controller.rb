class CustomersController < ApplicationController
  before_action :fetch_customer, only: %i[edit update show destroy]

  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(permitted_params)

    if @customer.save
      redirect_to customers_path, notice: 'Customer Successfully Stored'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @customer.update(permitted_params)
      redirect_to customer_path(@customer), notice: 'Customer Successfully Updated'
    else
      render :edit
    end
  end

  def destroy
    if @customer.destroy
      redirect_to customers_path, notice: 'Customer Successfully Destroyed'
    else
      render :index
    end
  end

  private

  def fetch_customer
    @customer = Customer.find(params[:id])
  end

  def permitted_params
    params.require(:customer).permit(:name, :email, :phone, :smoker, :avatar)
  end
end
