sudo apt-get update
sudo apt-get upgrade

sudo apt-get install build-essential -y

REDISVERSION=2.6.9
PORT=6379

cd ~/
wget http://redis.googlecode.com/files/redis-$REDISVERSION.tar.gz
tar xzf redis-$REDISVERSION.tar.gz
cd redis-$REDISVERSION
sudo make install

#installing redis proper
sudo mkdir /etc/redis 
sudo mkdir /var/redis

sudo cp ~/redis-$REDISVERSION/utils/redis_init_script /etc/init.d/redis_$PORT

#change port within, if different from 6379
sudo vi /etc/init.d/redis_$PORT

sudo cp ~/redis-$REDISVERSION/redis.conf /etc/redis/$PORT.conf

sudo mkdir /var/redis/$PORT

#Set daemonize to yes (by default it is set to no)
#Set the pidfile to /var/run/redis_6379.pid (modify the port if needed).
#Set the logfile to /var/log/redis_6379.log
#Set the dir to /var/redis/6379 (very important step!)
#set slaveof or AOF if needed
sudo vi /etc/redis/$PORT.conf

sudo update-rc.d redis_$PORT defaults

sudo /etc/init.d/redis_$PORT start