require "test_helper"

class BillableTest < ActiveSupport::TestCase

  def test_doesnt_charge_non_billable_accounts
    enrollments(:enrollment_not_ready_for_bill)
    enrollments(:enrollment_ready_for_bill)

    Payment.stub_any_instance(:charge, nil) do
      billed = Enrollment.charge_billable_accounts
      billed.map {|payment| payment.enrollment }.
        wont_include enrollments(:enrollment_not_ready_for_bill)
    end
  end

  def test_charges_billable_accounts
    enrollments(:enrollment_ready_for_bill)
    Payment.stub_any_instance(:charge, nil) do
      billed = Enrollment.charge_billable_accounts
      billed.map {|payment| payment.enrollment }.
        must_include enrollments(:enrollment_ready_for_bill)
    end
  end

  def test_doesnt_over_charge_accounts
    enrollments(:enrollment_last_payment_already_made)
    Payment.stub_any_instance(:charge, nil) do
      billed = Enrollment.charge_billable_accounts
      billed.map {|payment| payment.enrollment }.
        wont_include enrollments(:enrollment_last_payment_already_made)
    end
  end

  def test_charges_account_final_bill
    enrollments(:enrollment_needs_last_bill)
    Payment.stub_any_instance(:charge, nil) do
      billed = Enrollment.charge_billable_accounts
      billed.map {|payment| payment.enrollment }.
        must_include enrollments(:enrollment_needs_last_bill)
    end
  end

end
