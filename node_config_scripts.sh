# Change the permissions of the private key to 0600
sudo chmod 600 ~/.ssh/group10keypair.pem 

#Create a ~/.ssh/config file in order to not to need to type -i [private_key_name] every time
touch ~/.ssh/config
nano ~/.ssh/config
# Add the following to the file
Host 130.238.28.124 #The floating IP address or the host name of the machine.
    IdentityFile ~/.ssh/group10keypair.pem

# SSH:ing to the machine
ssh -L 8888:localhost:8888 -L 8080:localhost:8080 -L 4040:localhost:4040 ubuntu@130.238.28.124 

#////////////Inside each node///////////////#

# Check what is the hostname and set it
hostname
sudo nano /etc/hosts
# It becomes in this case:
# 127.0.0.1 group101

sudo apt-get update
sudo apt-get upgrade

# Install jdk
sudo apt-get install default-jdk

# Checking that Java is installed correctly
java -version
which java
readlink -f /usr/bin/java

#install pip
sudo apt-get install python3-pip

# Fixing locale not set error
# LC_ALL = (unset)
# perl: warning: Setting locale failed.
echo "export LANGUAGE=en_US.UTF-8 
export LANG=en_US.UTF-8 
export LC_ALL=en_US.UTF-8">>~/.profile
source ~/.profile

# Upgrade pip to the latest version
python3 -m pip install --upgrade pip

# Double check that the version is 10.0.1 
python3 -m pip --version

# Download Spark into home directory
wget http://apache.mirrors.spacedump.net/spark/spark-2.3.0/spark-2.3.0-bin-hadoop2.7.tgz

# Uncompress the Spark file
tar -zxvf spark-2.3.0-bin-hadoop2.7.tgz

# Remove the compressed file
rm spark-2.3.0-bin-hadoop2.7.tgz

# Install jupyter
sudo python3 -m pip install jupyter

# Add these lines to the end of ~/.bashrc
#Spark
export SPARK_HOME="/home/<your_username>/spark-2.3.0-bin-hadoop2.7/"

# Adding environment variables
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/
export SPARK_HOME=/home/ubuntu/spark-2.3.0-bin-hadoop2.7
export PATH=$PATH:/home/ubuntu/spark-2.3.0-bin-hadoop2.7/bin
export PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.6-src.zip:$PYTHONPATH
export PATH=$SPARK_HOME/python:$PATH
export PYSPARK_PYTHON=python3">>~/.profile

#update the .profile
source ~/.profile

# Making each node aware of each other 
sudo nano /etc/hosts

Change the hostname to the correct one

# Add these lines to the end
192.168.1.54 group101
192.168.1.166 group102
192.168.1.162 group103
192.168.1.163 group104
192.168.1.167 group105
192.168.1.174 group106

# Disable firewall
sudo ufw disable

# In each node
cd ~/.ssh/

# Download the private key to each node
wget https://filedn.com/lMeFQXHqV237y22exG4jHzQ/group10keypair.pem

# Change the permissions 
sudo chmod 600 ~/.ssh/group10keypair.pem 

# Test to connect to master node (group101)
ssh -i group10keypair.pem ubuntu@130.238.28.124

#////////////Setting up the cluster///////////////#
Create a snapshot of instance configured as above
Create 5 more instances from the snapshot




#////////////Inside master///////////////#
# From: 
# https://www.tutorialkart.com/apache-spark/how-to-setup-an-apache-spark-cluster/
# Copy SPARK_HOME/conf/spark-env.sh.template with name SPARK_HOME/conf/spark-env.sh 
cp spark-env.sh.template spark-env.sh
nano spark-env.sh
# Add the master internal IP address
spark-env.sh
# Options for the daemons used in the standalone deploy mode
# - SPARK_MASTER_HOST, to bind the master to a different IP address or hostname
SPARK_MASTER_HOST='192.168.1.54'
# - SPARK_MASTER_PORT / SPARK_MASTER_WEBUI_PORT, to use non-default ports for the master





#////////////Not used///////////////#

# Find the master IP 
ifconfig
# In the output, it's the ip address after inet in the second text block

./sbin/start-master.sh -h 127.0.0.1

# When now opening the browser with localhost:8080
# One can see the master URL, in this case it is:
# spark://127.0.0.1:7077 
localhost:8080
# Connect slaves to the master
./sbin/start-slave.sh spark://127.0.0.1:7077 