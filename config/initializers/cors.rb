Rails.application.configure do
  config.middleware.insert_before 0, Rack::Cors, debug: true, logger: ::Logger.new(STDOUT) do
    allow do
      if Rails.env.development?
        origins "pludoni.#{ENV['LOGNAME']}.pludoni.com"
      else
        origins 'www.pludoni.de'
      end
      resource '/api/v1/categories.json', headers: :any, methods: :get
      resource '/api/v1/news_items.json', headers: :any, methods: :get
    end
  end
end
