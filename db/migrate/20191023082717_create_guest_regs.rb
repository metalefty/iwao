class CreateGuestRegs < ActiveRecord::Migration[6.0]
  def change
    create_table :guest_regs do |t|
      t.string :full_name
      t.string :organization
      t.string :email
      t.string :alt_email
      t.string :purpose
      t.string :escort
      t.datetime :not_before
      t.datetime :not_after
      t.boolean :approved
      t.datetime :approved_at

      t.timestamps
    end
  end
end
