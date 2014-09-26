class CurrenciesController < ApplicationController
  before_action :set_currency, only: [:show, :edit, :update, :destroy]

  # GET /currencies
  # GET /currencies.json
  def index
    return redirect_to(presentations_url) unless current_user.has_any_role?(:admin) 
    @currencies = Currency.all
  end

  # GET /currencies/1
  # GET /currencies/1.json
  def show
    return redirect_to(presentations_url) unless current_user.has_any_role?(:admin) 
  end

  # GET /currencies/new
  def new
    return redirect_to(presentations_url) unless current_user.has_any_role?(:admin) 
    @currency = Currency.new
  end

  # GET /currencies/1/edit
  def edit
    return redirect_to(presentations_url) unless current_user.has_any_role?(:admin) 
  end

  # POST /currencies
  # POST /currencies.json
  def create
    return redirect_to(presentations_url) unless current_user.has_any_role?(:admin) 
    @currency = Currency.new(currency_params)

    respond_to do |format|
      if @currency.save
        format.html { redirect_to @currency, notice: 'Currency was successfully created.' }
        format.json { render action: 'show', status: :created, location: @currency }
      else
        format.html { render action: 'new' }
        format.json { render json: @currency.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /currencies/1
  # PATCH/PUT /currencies/1.json
  def update
    return redirect_to(presentations_url) unless current_user.has_any_role?(:admin) 
    respond_to do |format|
      if @currency.update(currency_params)
        format.html { redirect_to @currency, notice: 'Currency was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @currency.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /currencies/1
  # DELETE /currencies/1.json
  def destroy
    return redirect_to(presentations_url) unless current_user.has_any_role?(:admin) 
    @currency.destroy
    respond_to do |format|
      format.html { redirect_to currencies_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_currency
      @currency = Currency.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def currency_params
      params.require(:currency).permit(:name, :symbol)
    end
end
