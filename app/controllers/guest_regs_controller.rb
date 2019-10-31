class GuestRegsController < ApplicationController
  before_action :set_guest_reg, only: [:show, :edit, :update, :destroy]

  # GET /guest_regs
  # GET /guest_regs.json
  def index
    @guest_regs = GuestReg.all
  end

  # GET /guest_regs/1
  # GET /guest_regs/1.json
  def show
  end

  # GET /guest_regs/new
  def new
    @guest_reg = GuestReg.new
  end

  # GET /guest_regs/1/edit
  def edit
  end

  # POST /guest_regs
  # POST /guest_regs.json
  def create
    @guest_reg = GuestReg.new(guest_reg_params)

    respond_to do |format|
      if @guest_reg.save
        format.html { redirect_to @guest_reg, notice: 'Guest reg was successfully created.' }
        format.json { render :show, status: :created, location: @guest_reg }
      else
        format.html { render :new }
        format.json { render json: @guest_reg.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /guest_regs/1
  # PATCH/PUT /guest_regs/1.json
  def update
    respond_to do |format|
      if @guest_reg.update(guest_reg_params)
        format.html { redirect_to @guest_reg, notice: 'Guest reg was successfully updated.' }
        format.json { render :show, status: :ok, location: @guest_reg }
      else
        format.html { render :edit }
        format.json { render json: @guest_reg.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guest_regs/1
  # DELETE /guest_regs/1.json
  def destroy
    @guest_reg.destroy
    respond_to do |format|
      format.html { redirect_to guest_regs_url, notice: 'Guest reg was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guest_reg
      @guest_reg = GuestReg.find_by!(uuid: params[:uuid])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guest_reg_params
      params.require(:guest_reg).permit(:full_name, :organization, :email, :alt_email, :purpose, :escortant, :not_before, :not_after, :approved, :approved_at, :uuid)
    end
end
