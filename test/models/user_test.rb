require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Gabriel Boucher", 
                    email: "gboucher@stingray.com",
                    password: "password",
                    password_confirmation: "password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "  "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "  "
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 256
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    validEmails = %w[user@example.com GBOUCHER@stingray.ca gab_boucher-93@gmail.org]
    validEmails.each do |validEmail|
      @user.email = validEmail
      assert @user.valid?, "Address #{validEmail} should be valid"
    end
  end

  test "email validation should not accept invalid addresses" do
    invalidEmails = %w[use+r@example,com GBOUCHER_at_stingray.ca gab_boucher-93@gmail. gab_boucher-93@g_mail.com]
    invalidEmails.each do |invalidEmail|
      @user.email = invalidEmail
      assert_not @user.valid?, "Address #{invalidEmail} should be invalid"
    end
  end

  test "emails should be unique" do
    duplicateUser = @user.dup
    @user.save
    assert_not duplicateUser.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
