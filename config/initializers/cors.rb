Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*'  # Allow all origins (in production, you should restrict this)
  
      resource '/api/*',
               headers: :any,
               methods: [:get, :post, :options, :head]
    end
  end
  