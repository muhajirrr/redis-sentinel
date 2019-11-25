IP=$1

sudo apt-get update

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password admin'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password admin'

sudo apt-get install -y mysql-server
sudo service mysql restart

sudo apt-get install -y apache2
sudo apt-get install -y php libapache2-mod-php php-mysql
sudo cp /vagrant/wp-redis/000-default.conf /etc/apache2/sites-available/000-default.conf
sudo service apache2 restart

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

sudo chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

mysql -u root -padmin -e "CREATE DATABASE wordpress"

sudo -u vagrant mkdir wp
sudo -u vagrant wp core download --path=wp
sudo -u vagrant wp core config --dbname='wordpress' --dbuser='root' --dbpass='admin' --dbhost='localhost' --dbprefix='wp_' --path=wp
sudo -u vagrant wp core install --url="$IP" --title='Wordpress' --admin_user='admin' --admin_password='admin' --admin_email='admin@admin.com' --path=wp

sudo -u vagrant wp plugin install redis-cache --path=wp
sudo -u vagrant wp plugin activate redis-cache --path=wp