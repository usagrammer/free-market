module DummyData

  class PayjpCard
    def self.data
      {
        "id": "car_288b58c8fb174d154767aae5de98",
        "address_city": nil,
        "address_line1": nil,
        "address_line2": nil,
        "address_state": nil,
        "address_zip": nil,
        "address_zip_check": "unchecked",
        "brand": "Visa",
        "country": nil,
        "created": 1596864805,
        "customer": "cus_54a1904342988adc7671954ab47f",
        "cvc_check": "passed",
        "exp_month": 6,
        "exp_year": 2024,
        "fingerprint": "e1d8225886e3a7211127df751c86787f",
        "last4": "4242",
        "livemode": false,
        "metadata": {},
        "name": nil,
        "object": "card",
        "three_d_secure_status": nil
      }
    end

  end

  class PayjpCustomer
    def self.data
      {
        "id": "cus_54a1904342988adc7671954ab47f",
        "cards": {"count":1,"data":[PayjpCard.data],"has_more":false,"object":"list","url":"/v1/customers/cus_54a1904342988adc7671954ab47f/cards"},
        "created": 1596864808,
        "default_card": PayjpCard.data[:id],
        "description": nil,
        "email": nil,
        "livemode": false,
        "metadata": {},
        "object": "customer",
        "subscriptions": {"count":0,"data":[],"has_more":false,"object":"list","url":"/v1/customers/cus_54a1904342988adc7671954ab47f/subscriptions"}
      }
    end
  end

  class PayjpCharge
    def self.data
      {
        "id": "ch_ca3e575566a007d4324e77ced13f2",
        "amount": 12345,
        "amount_refunded": 0,
        "captured": true,
        "captured_at": 1596866723,
        "card": PayjpCard.data,
        "created": 1596866723,
        "currency": "jpy",
        "customer": PayjpCustomer.data[:id],
        "description": nil,
        "expired_at": nil,
        "failure_code": nil,
        "failure_message": nil,
        "livemode": false,
        "metadata": {},
        "object": "charge",
        "paid": true,
        "refund_reason": nil,
        "refunded": false,
        "subscription": nil
      }
    end
  end

end
