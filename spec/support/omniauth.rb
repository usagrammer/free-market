require './spec/support/dummy_data'

## 結合テストで必要
OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(DummyData::GoogleUser.data)
