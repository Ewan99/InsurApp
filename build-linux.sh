sudo docker build -t docker-insurapp .
sudo docker run --name InsurApp-Web --network=host -p 3080:3080 -d docker-insurapp
sudo docker-compose -f docker-compose-ca.yaml up -d
docker cp ./generatemsp.sh insurapp_ca.insurapp.com_1:/
docker cp ./configtx.yaml insurapp_ca.insurapp.com_1:/
docker cp ./ca insurapp_ca.insurapp.com_1:/
ddocker cp ./tlsca
sudo docker exec -it insurapp_ca.insurapp.com_1 sh ./generatemsp.sh
sudo docker exec -it insurapp_ca.insurapp.com_1 sh ./generatemsp-tls.sh
sudo docker exec -it insurapp_ca.insurapp.com_1 sh ./configtx.yaml
sudo docker exec -it insurapp_ca.insurapp.com_1 sh mkdir admincerts
