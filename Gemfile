source 'https://rubygems.org'

gem 'rails', '3.2.19'

gem 'locomotive_cms', '~> 2.5.6', :require => 'locomotive/engine'
gem 'locomotivecms-search', require: 'locomotive/search/mongoid'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'compass',        '~> 0.12.7'
  gem 'compass-rails',  '~> 2.0.0'
  gem 'sass-rails',     '~> 3.2.6'
  gem 'coffee-rails',   '~> 3.2.2'
  gem 'uglifier',       '~> 2.5.1'
  gem 'therubyracer', :platforms => :ruby
end

# Use unicorn as the app server
gem 'unicorn'

User.find_each do |user|
  user.save!(validate: false)
end

Locomotive::ContentType.where({ name: /^.*visitors.*$/i } ).first.entries.each do |user|
 user.save!
end



Locomotive::ContentType.where({ name: /^.*visitors.*$/i } ).first.entries.count



enbake17062014


localhost:3000/locomotive/api/search.json?auth_token=MyTAppqWJ1cdx9odKfiK&model=visitors&column[first_name]=LIAM&order[created_at]=desc&limit=100


Master::Studio.where(:code => 'lauren').first

{:studio_key=>"lauren", :job_id=>1027, :client_group_id=>663, :image_ids=>[1002370541, 1002370540, 1002370543, 1002370615, 1002370711, 1002370751, 1002370392], :csv_filename=>"/home/enbake/workspace/backdrop-proof/tmp/20150630-121425-7518.csv", :low_res=>false}