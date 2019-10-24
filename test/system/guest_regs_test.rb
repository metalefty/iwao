require "application_system_test_case"

class GuestRegsTest < ApplicationSystemTestCase
  setup do
    @guest_reg = guest_regs(:one)
  end

  test "visiting the index" do
    visit guest_regs_url
    assert_selector "h1", text: "Guest Regs"
  end

  test "creating a Guest reg" do
    visit guest_regs_url
    click_on "New Guest Reg"

    fill_in "Alt email", with: @guest_reg.alt_email
    check "Approved" if @guest_reg.approved
    fill_in "Approved at", with: @guest_reg.approved_at
    fill_in "Email", with: @guest_reg.email
    fill_in "Escortant", with: @guest_reg.escortant
    fill_in "Full name", with: @guest_reg.full_name
    fill_in "Not after", with: @guest_reg.not_after
    fill_in "Not before", with: @guest_reg.not_before
    fill_in "Organization", with: @guest_reg.organization
    fill_in "Purpose", with: @guest_reg.purpose
    click_on "Create Guest reg"

    assert_text "Guest reg was successfully created"
    click_on "Back"
  end

  test "updating a Guest reg" do
    visit guest_regs_url
    click_on "Edit", match: :first

    fill_in "Alt email", with: @guest_reg.alt_email
    check "Approved" if @guest_reg.approved
    fill_in "Approved at", with: @guest_reg.approved_at
    fill_in "Email", with: @guest_reg.email
    fill_in "Escortant", with: @guest_reg.escortant
    fill_in "Full name", with: @guest_reg.full_name
    fill_in "Not after", with: @guest_reg.not_after
    fill_in "Not before", with: @guest_reg.not_before
    fill_in "Organization", with: @guest_reg.organization
    fill_in "Purpose", with: @guest_reg.purpose
    click_on "Update Guest reg"

    assert_text "Guest reg was successfully updated"
    click_on "Back"
  end

  test "destroying a Guest reg" do
    visit guest_regs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Guest reg was successfully destroyed"
  end
end
