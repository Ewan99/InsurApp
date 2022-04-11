export FABRIC_CA_HOME=./roottlsca-admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:8054

export FABRIC_CA_HOME=./roottlsca-admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:8055

fabric-ca-client register --id.name orderer1.iaorderer.com --id.secret secret --id.type orderer -u http://localhost:8055
fabric-ca-client register --id.name orderer2.iaorderer.com --id.secret secret --id.type orderer -u http://localhost:8055
fabric-ca-client register --id.name orderer3.iaorderer.com --id.secret secret --id.type orderer -u http://localhost:8055
fabric-ca-client register --id.name peer1.iapeer.com --id.secret secret --id.type peer -u http://localhost:8054
fabric-ca-client register --id.name peer2.iapeer.com --id.secret secret --id.type peer -u http://localhost:8054
fabric-ca-client register --id.name peer3.iapeer.com --id.secret secret --id.type peer -u http://localhost:8054

fabric-ca-client register --id.name admin1.iaorderer.com --id.secret adminpw --id.type admin -u http://localhost:7055
fabric-ca-client register --id.name admin2.iaorderer.com --id.secret adminpw --id.type admin -u http://localhost:7055
fabric-ca-client register --id.name admin3.iaorderer.com --id.secret adminpw --id.type admin -u http://localhost:7055

fabric-ca-client register --id.name admin1.iapeer.com --id.secret adminpw --id.type admin -u http://localhost:7054
fabric-ca-client register --id.name admin2.iapeer.com --id.secret adminpw --id.type admin -u http://localhost:7054
fabric-ca-client register --id.name admin3.iapeer.com --id.secret adminpw --id.type admin -u http://localhost:7054
 
export FABRIC_CA_HOME=./orderers/iaorderer/orderer1/
fabric-ca-client enroll --csr.hosts "orderer1.iaorderer.com" -u http://orderer1.iaorderer.com:secret@localhost:8055 -M tls
export FABRIC_CA_HOME=./orderers/iaorderer/orderer2/
fabric-ca-client enroll --csr.hosts "orderer2.iaorderer.com" -u http://orderer2.iaorderer.com:secret@localhost:8055 -M tls
export FABRIC_CA_HOME=./orderers/iaorderer/orderer3/
fabric-ca-client enroll --csr.hosts "orderer3.iaorderer.com" -u http://orderer3.iaorderer.com:secret@localhost:8055 -M tls

export FABRIC_CA_HOME=./peers/iapeer/peer1/
fabric-ca-client enroll --csr.hosts "peer1.iapeer.com" -u http://peer1.iapeer.com:secret@localhost:8054 -M tls
export FABRIC_CA_HOME=./peers/iapeer/peer2/
fabric-ca-client enroll --csr.hosts "peer2.iapeer.com" -u http://peer2.iapeer.com:secret@localhost:8054 -M tls
export FABRIC_CA_HOME=./peers/iapeer/peer3/
fabric-ca-client enroll --csr.hosts "peer3.iapeer.com" -u http://peer3.iapeer.com:secret@localhost:8054 -M tls

sudo mv orderers/iaorderer/orderer1/tls/keystore/* orderers/iaorderer/orderer1/tls/keystore/server.key
sudo mv orderers/iaorderer/orderer2/tls/keystore/* orderers/iaorderer/orderer2/tls/keystore/server.key
sudo mv orderers/iaorderer/orderer3/tls/keystore/* orderers/iaorderer/orderer3/tls/keystore/server.key

sudo mv peers/iapeer/peer1/tls/keystore/* peers/iapeer/peer1/tls/keystore/server.key
sudo mv peers/iapeer/peer2/tls/keystore/* peers/iapeer/peer2/tls/keystore/server.key
sudo mv peers/iapeer/peer3/tls/keystore/* peers/iapeer/peer3/tls/keystore/server.key
