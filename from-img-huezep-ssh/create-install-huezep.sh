#define parameters which are passed in
YOUR_TARGET_CLUSTER=$1
YOUR_PROJECT=$2

#define the template
cat  << EOF
#!/bin/bash
sleep 45;
cd /opt/huezep;
sudo chmod 777 hue.sh |& tee -a /opt/huezep/output.txt;
sudo ./hue.sh |& tee -a /opt/huezep/output.txt;
sudo chmod 777 zeppelin.sh |& tee -a /opt/huezep/output.txt;
sudo ./zeppelin.sh |& tee -a /opt/huezep/output.txt;
sudo perl -pi -e s/hive_server_host=test-client-opt-init-4-structured-m.c.${YOUR_PROJECT}.internal/hive_server_host=${YOUR_TARGET_CLUSTER}-m.c.${YOUR_PROJECT}.internal/ /etc/hue/conf/hue.ini;
sudo perl -pi -e 's/## hive_server_port=10000/hive_server_port=10000/g' /etc/hue/conf/hue.ini;
sudo systemctl restart hue;
EOF


