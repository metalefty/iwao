class AddUuidtoGuestReg < ActiveRecord::Migration[6.0]
  def change
    add_column :guest_regs, :uuid, :string
  end
end
