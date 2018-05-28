Warden::Manager.after_authentication do |user,auth,opts|
  user.set_connection_code if user.user_key.nil?
end

Warden::Manager.before_logout do |user,auth,opts|
  user.clear_connection_code if user.user_key.nil?
end
