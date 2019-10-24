json.extract! guest_reg, :id, :full_name, :organization, :email, :alt_email, :purpose, :escortant, :not_before, :not_after, :approved, :approved_at, :created_at, :updated_at
json.url guest_reg_url(guest_reg, format: :json)
