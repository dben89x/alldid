CarrierWave.configure do |config|
	# config.root = Rails.root.join('tmp')
	# config.cache_dir = 'carrierwave'
	# if Rails.env.production?
		config.fog_credentials = {
			:provider               => 'AWS',                        # required
			:aws_access_key_id      => ENV['AWS_ACCESS_KEY'],                        # required
			:aws_secret_access_key  => ENV['AWS_SECRET_KEY'],                     # required
			:region                 => 'us-west-1',                  # optional, defaults to 'us-east-1'
		}
		config.fog_directory  = 'alldid'                             # required
	# end
end
