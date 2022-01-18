sudo docker build -t docker-insurapp .
sudo docker run --name InsurApp-Web --network=host -p 3080:3080 -d docker-insurapp
sudo docker-compose -f docker-compose-ca.yaml up -d
sudo docker exec -it insurapp_ca.insurapp.com_1 export FABRIC_CA_HOME=./rootca-admin
sudo docker exec -it insurapp_ca.insurapp.com_1 sudo ./generatemsp.sh