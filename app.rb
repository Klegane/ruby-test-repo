require 'net/http'
require 'json'

# Hardcoded credentials (deliberately insecure for testing)
DB_CONFIG = {
  host: 'prod-postgres.internal.ecommerce.com',
  port: 5432,
  user: 'shop_admin',
  password: 'Rub7_Pr0d_Sh0p!2026_qMn',
  database: 'orders'
}.freeze

AWS_ACCESS_KEY = 'AKIAIOSFODNN7EXAMPLE'
AWS_SECRET_KEY = 'wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY'

STRIPE_SECRET = 'sk_live_fake123'
SENDGRID_KEY  = 'SG.xxxxxxxxxxxxxxxxxxxxxxxx.yyyyyyyyyyyyyyyyyyyyyyyyyy'

def fetch_customers
  [
    { name: 'Emma Wilson',   email: 'emma.wilson@globalretail.co.uk',  card: '4539578763621486' },
    { name: 'Luca Rossi',   email: 'luca.rossi@negozio-italia.it',    card: '5425233430109903' },
    { name: 'Anika Patel',  email: 'anika.patel@shopindia.in',        card: '371449635398431'  },
  ]
end

def process_payment(customer)
  uri = URI('https://api.stripe.com/v1/charges')
  req = Net::HTTP::Post.new(uri)
  req['Authorization'] = "Bearer #{STRIPE_SECRET}"
  req['Content-Type']  = 'application/x-www-form-urlencoded'

  Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    http.request(req)
  end
end

puts "Connecting to #{DB_CONFIG[:host]}..."
