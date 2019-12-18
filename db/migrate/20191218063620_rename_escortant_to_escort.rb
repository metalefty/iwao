class RenameEscortantToEscort < ActiveRecord::Migration[6.0]
  def change
    rename_column :guest_regs, :escortant, :escort
  end
end
