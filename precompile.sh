echo '>> RAILS_ENV=production rake assets:precompile'
RAILS_ENV=production rake assets:precompile
echo '>> touch tmp/restart.txt'
touch tmp/restart.txt
