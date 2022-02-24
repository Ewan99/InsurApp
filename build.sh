#echo "#####################################"
#echo "#### Configuring Web Application ####"
#echo "#####################################"
#echo
#sudo docker run --name InsurApp-Web --network=host -p 3080:3080 -d docker-insurapp
#echo "Web App Server enabled!"
#echo
echo "################################"
echo "#### Starting CA Servers ####"
echo "################################"
echo
echo "Starting CA Containers..."
sudo docker-compose -f docker-compose-ca.yaml up -d
echo "CA Containers up!"
echo
echo "##########################"
echo "#### Configuring MSPs ####"
echo "##########################"
echo
sudo cp ca/server.crt orderers/iaorderer/msp/cacerts
sudo cp ca/server.crt peers/iapeer/msp/cacerts
sudo cp tlsca/server.crt orderers/iaorderer/msp/tlscacerts
sudo cp tlsca/server.crt peers/iapeer/msp/tlscacerts
sudo cp orderers/iaorderer/orderer1/msp/user/admin/signcerts/cert.pem orderers/iaorderer/msp/admincerts/
sudo cp peers/iapeer/peer1/msp/user/admin/signcerts/cert.pem peers/iapeer/msp/admincerts/
sudo cp orderers/iaorderer/orderer1/msp/user/admin/signcerts/cert.pem orderers/iaorderer/orderer1/msp/admincerts
sudo cp peers/iapeer/peer1/msp/user/admin/signcerts/cert.pem peers/iapeer/peer1/msp/admincerts
sudo cp peers/iapeer/peer1/msp/user/admin/signcerts/cert.pem peers/iapeer/peer1/msp/user/admin/admincerts/
echo
echo "####################################################"
echo "#### Creating Genesis Block and Default Channel ####"
echo "####################################################"
echo
mkdir admincerts
mkdir channel-artifacts
sudo configtxgen -profile genesis -outputBlock channel-artifacts/genesis.block -channelID default
sudo configtxgen -profile default -outputCreateChannelTx channel-artifacts/default.tx -channelID default
echo
echo "#####################################"
echo "#### Starting Blockchain Network ####"
echo "#####################################"
echo
sudo docker-compose up -d
echo
echo "############################################"
echo "#### Creating and joining Peer Channels ####"
echo "############################################"
echo
sudo docker exec -it cli bash -c peer channel create -f channel-artifacts/default.tx -c default -o orderer1.iaorderer.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/iapeer/msp/tlscacerts/server.crt
sudo docker exec -it cli bash -c peer channel join -b default.block -o orderer1.iaorderer.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/iapeer/msp/tlscacerts/server.crt
echo
echo "###################"
echo "#### Finished! ####"
echo "###################"
echo