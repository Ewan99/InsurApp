GREEN='\033[0;32m'
NC='\033[0m'
echo "________________________________________________________"
echo "  _____                                                 "
echo " |_   _|                           /\                   "
echo "   | |   _ __   ___  _   _  _ __  /  \    _ __   _ __   "
echo "   | |  | '_ \ / __|| | | || '__|/ /\ \  | '_ \ | '_ \  "
echo "  _| |_ | | | |\__ \| |_| || |  / ____ \ | |_) || |_) | "
echo " |_____||_| |_||___/ \__,_||_| /_/    \_\| .__/ | .__/  "
echo "                                         | |    | |     "
echo "                                         |_|    |_|     "
echo "________________________________________________________"
echo
echo "#####################################"
echo "#### Configuring Web Application ####"
echo "#####################################"
echo
sudo docker run --name InsurApp-Web --network=host -p 3080:3080 -d docker-insurapp
echo
printf " ${GREEN}Web App Server enabled!${NC}\n"
echo
echo "#############################"
echo "#### Starting CA Servers ####"
echo "#############################"
echo
printf " ${GREEN}Starting CA Containers...${NC}\n"
sudo docker-compose -f docker-compose-ca.yaml up -d
printf " ${GREEN}CA Containers up! Waiting 10s for containers to initialize...${NC}\n"
sleep 10
echo
echo "#########################"
echo "#### Configuring CAs ####"
echo "#########################"
echo
###peers
export FABRIC_CA_HOME=./rootca
fabric-ca-client enroll -u http://admin:adminpw@localhost:7054

fabric-ca-client register --id.name peer1.iapeer.com --id.secret secret --id.type peer -u http://localhost:7054
fabric-ca-client register --id.name peer2.iapeer.com --id.secret secret --id.type peer -u http://localhost:7054
fabric-ca-client register --id.name peer3.iapeer.com --id.secret secret --id.type peer -u http://localhost:7054

fabric-ca-client register --id.name admin1.iapeer.com --id.secret adminpw --id.type admin -u http://localhost:7054
fabric-ca-client register --id.name admin2.iapeer.com --id.secret adminpw --id.type admin -u http://localhost:7054
fabric-ca-client register --id.name admin3.iapeer.com --id.secret adminpw --id.type admin -u http://localhost:7054

export FABRIC_CA_HOME=./peers/iapeer/peer1/
fabric-ca-client enroll --csr.hosts "peer1.iapeer.com" -u http://peer1.iapeer.com:secret@localhost:7054
export FABRIC_CA_HOME=./peers/iapeer/peer2/
fabric-ca-client enroll --csr.hosts "peer2.iapeer.com" -u http://peer2.iapeer.com:secret@localhost:7054
export FABRIC_CA_HOME=./peers/iapeer/peer3/
fabric-ca-client enroll --csr.hosts "peer3.iapeer.com" -u http://peer3.iapeer.com:secret@localhost:7054

export FABRIC_CA_HOME=./peers/iapeer/peer1/msp/user/
fabric-ca-client enroll --csr.hosts "admin1.iapeer.com" -u http://admin1.iapeer.com:adminpw@localhost:7054 -M admin
export FABRIC_CA_HOME=./peers/iapeer/peer2/msp/user/
fabric-ca-client enroll --csr.hosts "admin2.iapeer.com" -u http://admin2.iapeer.com:adminpw@localhost:7054 -M admin
export FABRIC_CA_HOME=./peers/iapeer/peer3/msp/user/
fabric-ca-client enroll --csr.hosts "admin3.iapeer.com" -u http://admin3.iapeer.com:adminpw@localhost:7054 -M admin
###orderers###
export FABRIC_CA_HOME=./rootca
fabric-ca-client enroll -u http://admin:adminpw@localhost:7055

fabric-ca-client register --id.name orderer1.iaorderer.com --id.secret secret --id.type orderer -u http://localhost:7055
fabric-ca-client register --id.name orderer2.iaorderer.com --id.secret secret --id.type orderer -u http://localhost:7055
fabric-ca-client register --id.name orderer3.iaorderer.com --id.secret secret --id.type orderer -u http://localhost:7055

fabric-ca-client register --id.name admin1.iaorderer.com --id.secret adminpw --id.type admin -u http://localhost:7055
fabric-ca-client register --id.name admin2.iaorderer.com --id.secret adminpw --id.type admin -u http://localhost:7055
fabric-ca-client register --id.name admin3.iaorderer.com --id.secret adminpw --id.type admin -u http://localhost:7055

export FABRIC_CA_HOME=./orderers/iaorderer/orderer1/
fabric-ca-client enroll --csr.hosts "orderer1.iaorderer.com" -u http://orderer1.iaorderer.com:secret@localhost:7055
export FABRIC_CA_HOME=./orderers/iaorderer/orderer2/
fabric-ca-client enroll --csr.hosts "orderer2.iaorderer.com" -u http://orderer2.iaorderer.com:secret@localhost:7055
export FABRIC_CA_HOME=./orderers/iaorderer/orderer3/
fabric-ca-client enroll --csr.hosts "orderer3.iaorderer.com" -u http://orderer3.iaorderer.com:secret@localhost:7055

export FABRIC_CA_HOME=./orderers/iaorderer/orderer1/msp/user/
fabric-ca-client enroll --csr.hosts "admin1.iaorderer.com" -u http://admin1.iaorderer.com:adminpw@localhost:7055 -M admin
export FABRIC_CA_HOME=./orderers/iaorderer/orderer2/msp/user/
fabric-ca-client enroll --csr.hosts "admin2.iaorderer.com" -u http://admin2.iaorderer.com:adminpw@localhost:7055 -M admin
export FABRIC_CA_HOME=./orderers/iaorderer/orderer3/msp/user/
fabric-ca-client enroll --csr.hosts "admin3.iaorderer.com" -u http://admin3.iaorderer.com:adminpw@localhost:7055 -M admin
echo
echo "#############################"
echo "#### Configuring TLS CAs ####"
echo "#############################"
echo
###peers###
export FABRIC_CA_HOME=./roottlsca
fabric-ca-client enroll -u http://admin:adminpw@localhost:8054

fabric-ca-client register --id.name peer1.iapeer.com --id.secret secret --id.type peer -u http://localhost:8054
fabric-ca-client register --id.name peer2.iapeer.com --id.secret secret --id.type peer -u http://localhost:8054
fabric-ca-client register --id.name peer3.iapeer.com --id.secret secret --id.type peer -u http://localhost:8054

export FABRIC_CA_HOME=./peers/iapeer/peer1/
fabric-ca-client enroll --csr.hosts "peer1.iapeer.com" -u http://peer1.iapeer.com:secret@localhost:8054 -M tls
export FABRIC_CA_HOME=./peers/iapeer/peer2/
fabric-ca-client enroll --csr.hosts "peer2.iapeer.com" -u http://peer2.iapeer.com:secret@localhost:8054 -M tls
export FABRIC_CA_HOME=./peers/iapeer/peer3/
fabric-ca-client enroll --csr.hosts "peer3.iapeer.com" -u http://peer3.iapeer.com:secret@localhost:8054 -M tls
###orderers###
export FABRIC_CA_HOME=./roottlsca
fabric-ca-client enroll -u http://admin:adminpw@localhost:8055

fabric-ca-client register --id.name orderer1.iaorderer.com --id.secret secret --id.type orderer -u http://localhost:8055
fabric-ca-client register --id.name orderer2.iaorderer.com --id.secret secret --id.type orderer -u http://localhost:8055
fabric-ca-client register --id.name orderer3.iaorderer.com --id.secret secret --id.type orderer -u http://localhost:8055


export FABRIC_CA_HOME=./orderers/iaorderer/orderer1/
fabric-ca-client enroll --csr.hosts "orderer1.iaorderer.com" -u http://orderer1.iaorderer.com:secret@localhost:8055 -M tls
export FABRIC_CA_HOME=./orderers/iaorderer/orderer2/
fabric-ca-client enroll --csr.hosts "orderer2.iaorderer.com" -u http://orderer2.iaorderer.com:secret@localhost:8055 -M tls
export FABRIC_CA_HOME=./orderers/iaorderer/orderer3/
fabric-ca-client enroll --csr.hosts "orderer3.iaorderer.com" -u http://orderer3.iaorderer.com:secret@localhost:8055 -M tls

#rename keys
sudo mv orderers/iaorderer/orderer1/tls/keystore/* orderers/iaorderer/orderer1/tls/keystore/server.key
sudo mv orderers/iaorderer/orderer2/tls/keystore/* orderers/iaorderer/orderer2/tls/keystore/server.key
sudo mv orderers/iaorderer/orderer3/tls/keystore/* orderers/iaorderer/orderer3/tls/keystore/server.key

sudo mv peers/iapeer/peer1/tls/keystore/* peers/iapeer/peer1/tls/keystore/server.key
sudo mv peers/iapeer/peer2/tls/keystore/* peers/iapeer/peer2/tls/keystore/server.key
sudo mv peers/iapeer/peer3/tls/keystore/* peers/iapeer/peer3/tls/keystore/server.key
echo
echo "##########################"
echo "#### Configuring MSPs ####"
echo "##########################"
echo
printf " ${GREEN}Copyting CA Server Certs...${NC}\n"
sudo cp ca/orderer-ca-server.crt orderers/iaorderer/msp/cacerts
sudo cp ca/peer-ca-server.crt peers/iapeer/msp/cacerts
sudo cp tlsca/orderer-tlsca-server.crt orderers/iaorderer/msp/tlscacerts
sudo cp tlsca/peer-tlsca-server.crt peers/iapeer/msp/tlscacerts
printf " ${GREEN}Copyting Orderer Admin Private Keys...${NC}\n"
sudo cp orderers/iaorderer/orderer1/msp/user/admin/signcerts/cert.pem orderers/iaorderer/msp/admincerts/ordereradmin1.pem
sudo cp orderers/iaorderer/orderer2/msp/user/admin/signcerts/cert.pem orderers/iaorderer/msp/admincerts/ordereradmin2.pem
sudo cp orderers/iaorderer/orderer3/msp/user/admin/signcerts/cert.pem orderers/iaorderer/msp/admincerts/ordereradmin3.pem
sudo cp orderers/iaorderer/orderer1/msp/user/admin/signcerts/cert.pem orderers/iaorderer/orderer1/msp/admincerts
sudo cp orderers/iaorderer/orderer1/msp/user/admin/signcerts/cert.pem orderers/iaorderer/orderer1/msp/user/admin/admincerts
sudo cp orderers/iaorderer/orderer2/msp/user/admin/signcerts/cert.pem orderers/iaorderer/orderer2/msp/admincerts
sudo cp orderers/iaorderer/orderer2/msp/user/admin/signcerts/cert.pem orderers/iaorderer/orderer2/msp/user/admin/admincerts
sudo cp orderers/iaorderer/orderer3/msp/user/admin/signcerts/cert.pem orderers/iaorderer/orderer3/msp/admincerts
sudo cp orderers/iaorderer/orderer3/msp/user/admin/signcerts/cert.pem orderers/iaorderer/orderer3/msp/user/admin/admincerts
printf " ${GREEN}Copyting Peer Admin Private Keys...${NC}\n"
sudo cp peers/iapeer/peer1/msp/user/admin/signcerts/cert.pem peers/iapeer/msp/admincerts/peeradmin1.pem
sudo cp peers/iapeer/peer2/msp/user/admin/signcerts/cert.pem peers/iapeer/msp/admincerts/peeradmin2.pem
sudo cp peers/iapeer/peer3/msp/user/admin/signcerts/cert.pem peers/iapeer/msp/admincerts/peeradmin3.pem
sudo cp peers/iapeer/peer1/msp/user/admin/signcerts/cert.pem peers/iapeer/peer1/msp/admincerts
sudo cp peers/iapeer/peer1/msp/user/admin/signcerts/cert.pem peers/iapeer/peer1/msp/user/admin/admincerts/
sudo cp peers/iapeer/peer2/msp/user/admin/signcerts/cert.pem peers/iapeer/peer2/msp/admincerts
sudo cp peers/iapeer/peer2/msp/user/admin/signcerts/cert.pem peers/iapeer/peer2/msp/user/admin/admincerts/
sudo cp peers/iapeer/peer3/msp/user/admin/signcerts/cert.pem peers/iapeer/peer3/msp/admincerts
sudo cp peers/iapeer/peer3/msp/user/admin/signcerts/cert.pem peers/iapeer/peer3/msp/user/admin/admincerts/
echo
echo "####################################################"
echo "#### Creating Genesis Block and Default Channel ####"
echo "####################################################"
echo
printf " ${GREEN}Creating Genesis Block...${NC}\n"
sudo configtxgen -profile genesis -outputBlock channel-artifacts/genesis.block -channelID genesis
printf " ${GREEN}Creating Default Channel...${NC}\n"
sudo configtxgen -profile default -outputCreateChannelTx channel-artifacts/default.tx -channelID default
echo
echo "#####################################"
echo "#### Starting Blockchain Network ####"
echo "#####################################"
echo
sudo docker-compose up -d
echo
printf " ${GREEN}All peers created! - Waiting 5s for peers to initalize${NC}\n"
sleep 5
echo
echo "############################################"
echo "#### Creating and joining Peer Channels ####"
echo "############################################"
echo
printf " ${GREEN}Creating Peer Channel...${NC}\n"
sudo docker exec cli peer channel create -f channel-artifacts/default.tx -c default -o orderer1.iaorderer.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/iaorderer/msp/tlscacerts/orderer-tlsca-server.crt
printf " ${GREEN}Joining Peer channel...${NC}\n"
sudo docker exec cli peer channel join -o orderer1.iaorderer.com:7050 -b default.block --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/iapeer/msp/tlscacerts/orderer-tlsca-server.crt
echo
echo "#########################################"
echo "#### Install & Instantiate Chaincode ####"
echo "#########################################"
printf " ${GREEN}Packaging & Installing chaincode...${NC}\n"
echo
sudo docker exec cli mkdir /opt/gopath/src/chaincode/packaged
sudo docker exec cli peer chaincode package /opt/gopath/src/chaincode/packaged/chaincode.tar.gz -n chaincode -v 1.0 -p chaincode
echo
printf " ${GREEN}Installing chaincode...${NC}\n"
echo
sudo docker exec cli peer chaincode install -n chaincode -v 1.0 -p chaincode/packaged chaincode.tar.gz
sudo docker exec cli cp /opt/gopath/src/chaincode/packaged/chaincode.tar.gz /usr/local/src
#echo
#printf " ${GREEN}Instantiating chaincode...${NC}\n"
#echo
#sudo docker exec peer1.iapeer.com GO111MODULE=auto peer chaincode instantiate -C default -n chaincode -l "golang" -v 1.0 -c '{"Args":["InitLedger"]}' --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/iaorderer/msp/tlscacerts/orderer-tlsca-server.crt #/etc/hyperledger/fabric/msp/orderer-tlsintermediatecerts/orderer-tlsca-server.crt    
echo
echo "########################"
echo "#### Finished Build ####"
echo "########################"
echo
