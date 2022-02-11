sudo docker build -t docker-insurapp .
echo "#####################################"
echo "#### Configuring Web Application ####"
echo "#####################################"
echo
sudo docker run --name InsurApp-Web --network=host -p 3080:3080 -d docker-insurapp
echo "Web App Server enabled!"
echo
echo "###########################################"
echo "#### Configuring Certificate Authority ####"
echo "###########################################"
echo
echo "Starting CA Containers..."
sudo docker-compose -f docker-compose-ca.yaml up -d
echo "CA Containers up!"
echo
echo "#################################################"
echo "#### Copying necessary files to CA container ####"
echo "#################################################"
echo
echo "Copying 'generatemsp.sh'..."
docker cp ./generatemsp.sh insurapp_ca.insurapp.com_1:/
echo "Copying 'generatemsp-tls.sh'..."
docker cp ./generatemsp-tls.sh insurapp_tlsca.insurapp.com_1:/
echo "Copying 'configtx.yaml'..."
docker cp ./configtx.yaml insurapp_ca.insurapp.com_1:/
echo "Copying 'configtxgen'..."
docker cp ./configtxgen insurapp_ca.insurapp.com_1:/
echo "Copying 'cryptogen'..."
docker cp ./cryptogen insurapp_ca.insurapp.com_1:/
echo "Copying 'ca' folder..."
docker cp ./ca insurapp_ca.insurapp.com_1:/
echo "Copying 'tlsca' folder..."
docker cp ./tlsca insurapp_tlsca.insurapp.com_1:/
echo "Copying 'hyperledger' folder..."
docker cp ./hyperledger insurapp_ca.insurapp.com_1:/
echo "Copying 'peers' folder..."
docker cp ./peers insurapp_ca.insurapp.com_1:/
echo "Copying 'orderers' folder..."
docker cp ./orderers insurapp_ca.insurapp.com_1:/
echo
echo "All files copied!"
echo
echo "##########################"
echo "#### Configuring MSPs ####"
echo "##########################"
echo
echo "Configuring CA MSP..."
echo
sudo docker exec -it insurapp_ca.insurapp.com_1 sh ./generatemsp.sh
echo
echo "Configuring TLS CA MSP..."
echo
sudo docker exec -it insurapp_tlsca.insurapp.com_1 sh ./generatemsp-tls.sh
echo
echo "Building Channels..."
echo
sudo docker exec -it insurapp_ca.insurapp.com_1 bash -c "mkdir admincerts"
sudo docker exec -it insurapp_ca.insurapp.com_1 bash -c "mkdir channel-artifacts"
echo
echo "Creating Genesis Blocks..."
echo
sudo docker exec -it insurapp_ca.insurapp.com_1 bash -c "./configtxgen -profile genesis -outputBlock channel-artifacts/genesis.block -channelID default"
echo
echo "Create Channels..."
echo
sudo docker exec -it insurapp_ca.insurapp.com_1 bash -c "./configtxgen -profile default -outputCreateChannelTx channel-artifacts/default.tx -channelID default"