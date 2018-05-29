echo '>> RAILS_ENV=production rails db:drop DISABLE_DATABASE_ENVIRONMENT_CHECK=1'
RAILS_ENV=production rails db:drop DISABLE_DATABASE_ENVIRONMENT_CHECK=1
echo '>> RAILS_ENV=production rails db:create'
RAILS_ENV=production rails db:create
echo '>> RAILS_ENV=production rails db:migrate'
RAILS_ENV=production rails db:migrate
echo '>> RAILS_ENV=production rails db:seed'
RAILS_ENV=production rails db:seed

