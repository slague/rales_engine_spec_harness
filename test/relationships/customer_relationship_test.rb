require "./test/test_helper"
class CustomerApiRelationshipTest < ApiTest
  def test_loads_a_collection_of_invoices_associated_with_one_customer
    customer_id = 309

    invoices = load_data("/api/v1/customers/#{customer_id}/invoices")
    assert_equal 6, invoices.count
    assert_equal 1602, invoices.first["id"]
    assert_equal 22, invoices.last["merchant_id"]

    invoices.each do |invoice|
      assert_equal customer_id, invoice["customer_id"]
      assert_class_equal "invoice", invoice
    end
  end

  def test_loads_a_collection_of_transaction_associated_with_one_customer
    customer_id = 29

    transactions = load_data("/api/v1/customers/#{customer_id}/transactions").flatten
    assert_equal 8, transactions.count
    assert_equal 168, transactions.first["id"]
    assert_equal "4410437213033941", transactions.last["credit_card_number"]
    transactions.each do |transaction|
      assert_class_equal "transaction", transaction
    end
  end
end
