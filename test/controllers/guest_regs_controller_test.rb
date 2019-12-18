require 'test_helper'

class GuestRegsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @guest_reg = guest_regs(:one)
  end

  test "should get index" do
    get guest_regs_url
    assert_response :success
  end

  test "should get new" do
    get new_guest_reg_url
    assert_response :success
  end

  test "should create guest_reg" do
    assert_difference('GuestReg.count') do
      post guest_regs_url, params: { guest_reg: { alt_email: @guest_reg.alt_email, approved: @guest_reg.approved, approved_at: @guest_reg.approved_at, email: @guest_reg.email, escort: @guest_reg.escort, full_name: @guest_reg.full_name, not_after: @guest_reg.not_after, not_before: @guest_reg.not_before, organization: @guest_reg.organization, purpose: @guest_reg.purpose } }
    end

    assert_redirected_to guest_reg_url(GuestReg.last)
  end

  test "should show guest_reg" do
    get guest_reg_url(@guest_reg)
    assert_response :success
  end

  test "should get edit" do
    get edit_guest_reg_url(@guest_reg)
    assert_response :success
  end

  test "should update guest_reg" do
    patch guest_reg_url(@guest_reg), params: { guest_reg: { alt_email: @guest_reg.alt_email, approved: @guest_reg.approved, approved_at: @guest_reg.approved_at, email: @guest_reg.email, escort: @guest_reg.escort, full_name: @guest_reg.full_name, not_after: @guest_reg.not_after, not_before: @guest_reg.not_before, organization: @guest_reg.organization, purpose: @guest_reg.purpose } }
    assert_redirected_to guest_reg_url(@guest_reg)
  end

  test "should destroy guest_reg" do
    assert_difference('GuestReg.count', -1) do
      delete guest_reg_url(@guest_reg)
    end

    assert_redirected_to guest_regs_url
  end
end
