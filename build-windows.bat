docker build -t docker-insurapp .
docker run --name InsurApp --network=host -p 3080:3080 -d docker-insurapp
docker-compose -f docker-compose-ca.yaml up -d
sudo docker exec -it insurapp_ca.insurapp.com_1 export FABRIC_CA_HOME=./rootca-admin
sudo docker exec -it insurapp_ca.insurapp.com_1 fabric-ca-client enroll -u http://admin:1907ed@localhost:7054