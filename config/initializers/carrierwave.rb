CarrierWave.configure do |config|
	# config.root = Rails.root.join('tmp')
	# config.cache_dir = 'carrierwave'
	# if Rails.env.production?
		config.fog_credentials = {
			:provider               => 'AWS',                        # required
			:aws_access_key_id      => ENV['aws_access_key'],                        # required
			:aws_secret_access_key  => ENV['aws_secret_key'],                     # required
			:region                 => 'us-east-1',                  # optional, defaults to 'us-east-1'
		}
		config.fog_directory  = 'alldid'                             # required
	# end
end
