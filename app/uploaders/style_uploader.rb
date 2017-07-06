# encoding: utf-8

class StyleUploader < CarrierWave::Uploader::Base

	storage :fog

	def store_dir
		if Rails.env.development?
			"dev"
		else
			"styles"
		end
	end

	def extension_whitelist
		%w(png, jpg, jpeg, svg)
	end

end
