CarrierWave.configure do |config|
  permissions 0777
  config.cache_dir = File.join(Rails.root, 'tmp', 'uploads')

  case Rails.env.to_sym

  when :development
    config.storage = :file
    config.root = File.join(Rails.root, 'public')

  when :production
    # the following configuration works for Amazon S3
    config.storage          = :fog
    config.fog_credentials = {
    :provider               => 'AWS',                        
    :aws_access_key_id      => "AKIAJMV6IAIXZQJJ2GHQ",    
    :aws_secret_access_key  => "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" 
  }
  config.fog_directory  = "com.neuronicgames.neuroncms/testcontent"                  


  else
    # settings for the local filesystem
    config.storage = :file
    config.root = File.join(Rails.root, 'public')
  end

end

# CarrierWave.configure do |config|
#   config.fog_credentials = {
#     :provider               => 'AWS',                        
#     :aws_access_key_id      => "AKIAJYXFJGF3O4D52GTQ",    
#     :aws_secret_access_key  => "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" 
#   }
#   config.fog_directory  = "com.neuronicgames.neuroncms/content"                  
#   config.fog_public     = false                                   
#   config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  
#   config.fog_authenticated_url_expiration = 604800
# end




# S3_KEY:                       AKIAJMV6IAIXZQJJ2GHQ
# S3_PATH:                      com.neuronicgames.neuroncms/content
# S3_PROTOCOL:                  https
# S3_SECRET:                    qwX9pSUr8vD+CGHIP1w4tYEpWV6dsK3gSkdneY/V