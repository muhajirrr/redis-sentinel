IP=$1
IP_MASTER="192.168.16.104"
REDIS_PORT=6379

sudo cp /vagrant/redis/redis-* /home/vagrant/
sudo cp /vagrant/conf/sentinel.conf /etc/sentinel.conf
sudo cp /vagrant/conf/redis.conf /etc/redis.conf

sudo sed -i "s/bind 127.0.0.1/bind $IP/" /etc/sentinel.conf
sudo sed -i "s/sentinel monitor mymaster 127.0.0.1 6379 2/sentinel monitor mymaster $IP_MASTER $REDIS_PORT 2/" /etc/sentinel.conf

sudo sed -i "s/bind 127.0.0.1/bind $IP/" /etc/redis.conf
sudo sed -i "s/protected-mode yes/protected-mode no/" /etc/redis.conf
sudo sed -i "s/daemonize no/daemonize yes/" /etc/redis.conf

sudo ./redis-server /etc/redis.conf
sudo ./redis-sentinel /etc/sentinel.conf