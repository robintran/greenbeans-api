merchant = Merchant.find_by_email 'fran@greenbean.com'
merchant = Merchant.create(email: 'fran@greenbean.com', name: 'fran', password: 'password', password_confirmation: 'password') unless merchant

consumer = User.find_by_email 'bhanu@greenbean.com'
consumer = User.create(email: 'bhanu@greenbean.com', password: 'password', password_confirmation: 'password') unless consumer

token = merchant.tokens.create(beans_count: 20)

token.beans.each do |bean|
  bean.user = consumer
  bean.used_on = ["raffle","gift","none"].sample
  bean.redeemed = [true,false].sample
  bean.save
end
