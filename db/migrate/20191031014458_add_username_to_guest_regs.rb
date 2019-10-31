class AddUsernameToGuestRegs < ActiveRecord::Migration[6.0]
  def change
    add_column :guest_regs, :username, :string
  end
end
