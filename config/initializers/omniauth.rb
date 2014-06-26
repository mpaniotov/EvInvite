Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "253685201490975", "641047711b0df4ec4bbe82e9b8a1e1b6"
  provider :twitter, ENV["TWITTER_CLIENT_ID"], ENV["TWITTER_CLIENT_SECRET"]
end
