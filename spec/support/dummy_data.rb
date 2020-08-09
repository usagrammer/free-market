module DummyData

  class GoogleUser
    def self.data  ## SNS認証でのrequest.env["omniauth.auth"]のダミー
      {
        "provider"=>"google_oauth2",
        "uid"=>"10304324527584231",
        "info"=>
         {"name"=>"ホゲ太郎",
          "email"=>"hoge.fuga@bar.co.jp",
          "unverified_email"=>"hoge.fuga@bar.co.jp",
          "email_verified"=>true,
          "first_name"=>"太郎",
          "last_name"=>"ホゲ",
          "image"=>"https://lh3.googleusercontent.com/-M_QnK8__qMU/AAdwndfndAI/AxxXXXXXXXXXXXXX/AMZuuckA3FYeHLDAmc-EF6-GGSdawdaaghA/photo.jpg"},
        "credentials"=>
         {"token"=>
           "yafaesfafagaragargapkg;aoaroigjaiiiiiioiagiagjeoKR6_U",
          "refresh_token"=>"kpotshkoirhjasiougaalvnaiufefwadmsRl8",
          "expires_at"=>15601249,
          "expires"=>true},
        "extra"=>
         {"id_token"=>
           "eyJhbGcijogriaogaohvaniuahfeuiiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY2dwad91bnRzLmdvb2dsZS5jb20iLCJhenAiOiIzNDIwNDM0ODU0ODMtMDAwOGI5cWJpN2lyZTBuaTJ1ZjJkcWVyZ2k2dWYxdjEuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIzNDIwNDM0ODU0ODMtMDAwOGI5cWJpN2lyZTBuaTJ1ZjJkcWVyZ2k2dWYxdjEuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDMwOTcxNjcwMDUzMjc1ODY4NDkiLCJoZCI6ImRpLXYuY28uanAiLCJlbWFpbCI6Inl1a2kudW5vQGRpLXYuY28uanAiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiYXRfaGFzaCI6IngxVzRJbXZoMVlFT1YwNEJxSV9uUHciLCJuYW1lIjoi6bWc6YeO5L2R57SAIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS8tTV9Rbks4X19xTVUvQUFBQUFBQUFBQUkvQUFBQUFBQUFBQUEvQU1adXVja0EzRlllSExEQW1jLUVGNi1HR1NIZjdFaEtZQS9zOTYtYy9waG90by5qcGciLCJnaXZlbl9uYW1lIjoi5L2R57SAIiwiZmFtaWx5X25hbWUiOiLptZzph44iLCJsb2NhbGUiOiJqYSIsImlhdCI6MTU5NjY5OTQ5OSwiZXhwIjoxNTk2NzAzMDk5fQ.SpsecBa0PxGYZiakrAw_JYxI_EV14QDA1Pjxd-4AWo0DZ_d42hvgQPHlhvPyHEIW3z7TsO7akVpy8XffTWY0aEp1OkRGlLjv5keLZrRNAk-JLJUY9p8hkNGNNC0TWZIOVJqffV8WjTjiwqY6y9-lN-AeovzW5plWlf4Mba0044spiLz6lbjqHzcsJeA2wf7hnQn6klnvxbtHeb2RpkBTXrMGKlMp9XgyI9gujM6802ioYcy8V50poVcMWK6wDAkvIy2c8O0mxqHoF7_a1oP-FSxrkuYX314qWCTwKQSJTzqKqHbnNePxdqOy8-iiwXVdeyYIx7wtDfDKke0sEzKUNw",
          "id_info"=>
           {"iss"=>"https://accounts.google.com",
            "azp"=>"7453485483-0008dawggrwabadbadhraefgi6uf1v1.apps.googleusercontent.com",
            "aud"=>"7453485483-0008dawggrwabadbadhraefgi6uf1v1.apps.googleusercontent.com",
            "sub"=>"7654862344586849",
            "hd"=>"bar.co.jp",
            "email"=>"hoge.fuga@bar.co.jp",
            "email_verified"=>true,
            "at_hash"=>"x463225ihddBqI_nPw",
            "name"=>"ホゲ太郎",
            "picture"=>"https://lh3.googleusercontent.com/-M_QnK8__qMU/AAdwndfndAI/AxxXXXXXXXXXXXXX/AMZuuckA3FYeHLDAmc-EF6-GGSdawdaaghA/photo.jpg",
            "given_name"=>"太郎",
            "family_name"=>"ホゲ",
            "locale"=>"ja",
            "iat"=>15966432324,
            "exp"=>1239672199},
          "raw_info"=>
           {"sub"=>"10906304286849",
            "name"=>"ホゲ太郎",
            "given_name"=>"ホゲ",
            "family_name"=>"太郎",
            "picture"=>"https://lh3.googleusercontent.com/-M_QnK8__qMU/AAdwndfndAI/AxxXXXXXXXXXXXXX/AMZuuckA3FYeHLDAmc-EF6-GGSdawdaaghA/photo.jpg",
            "email"=>"hoge.fuga@bar.co.jp",
            "email_verified"=>true,
            "locale"=>"ja",
            "hd"=>"bar.co.jp"
           }
         }
       }
    end
  end

  class PayjpCard  ## カード情報のダミー
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

  class PayjpCustomer  ## 顧客情報のダミー
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

  class PayjpCharge  ## 支払い結果のダミー
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
