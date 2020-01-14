class GuestRegsController < ApplicationController
  before_action :set_guest_reg, only: [:show, :edit, :update, :destroy, :approve]

  # GET /guest_regs
  # GET /guest_regs.json
  def index
    @guest_regs = GuestReg.all
    # temporarily disabled
    redirect_to new_guest_reg_url, status: :see_other
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

  # GET /guest_regs/sent
  def sent
  end

  # GET /guest_regs/approved
  def approved
  end

  def approve
    if @guest_reg.approved?
      redirect_to @guest_reg and return
    end

    if @guest_reg.approve
      notifier = GuestRegNotifier.new(@guest_reg)
      notifier.slack_approved
      notifier.email_registration_approved
    end

    redirect_to approved_guest_regs_path
  end

  # GET /guest_regs/confirm
  def confirm
    @guest_reg = GuestReg.new(guest_reg_params)

    if @guest_reg.invalid?
      render :new
    end
  end


  # POST /guest_regs
  # POST /guest_regs.json
  def create
    @guest_reg = GuestReg.new(guest_reg_params)

    if params[:back]
      render :new and return
    end

    if !verify_recaptcha(model: @guest_reg)
      render :confirm and return
    end

    respond_to do |format|
      if @guest_reg.save
        notifier = GuestRegNotifier.new(@guest_reg)
        notifier.slack_request_for_approval
        notifier.email_request_for_approval
        notifier.email_registration_receipt

        format.html { redirect_to sent_guest_regs_url, status: :see_other }
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
      params.require(:guest_reg).permit(:full_name, :organization, :email, :alt_email, :purpose, :escort, :not_before, :not_after, :approved, :approved_at, :uuid)
    end
end
