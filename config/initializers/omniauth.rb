Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, "", "", setup: true
  provider :twitter, "", "", setup: true
end
