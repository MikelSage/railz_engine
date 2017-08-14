require 'rails_helper'

RSpec.describe 'Customer API' do
  it "returns a list of all customers" do
    create_list(:customer, 3)

    get '/api/v1/customers.json'

    expect(response).to be_success

    customers = JSON.parse(response.body)

    expect(customers.count).to eq(3)
  end
end
