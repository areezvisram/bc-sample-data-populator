# LOCAL:
# Rails.application.config.session_store :cookie_store, key: 'bc-sample-data-populator', same_site: :lax, secure: false

# PRODUCTION:
Rails.application.config.session_store :cookie_store, key: 'bc-sample-data-populator', same_site: :none, secure: true