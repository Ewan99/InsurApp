export FABRIC_CA_HOME=./roottlsca-admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:8054

fabric-ca-client register --id.name orderer1.iaorderer.com --id.secret secret --id.type orderer -u http://localhost:8054
fabric-ca-client register --id.name peer1.iapeer.com --id.secret secret --id.type peer -u http://localhost:8054
 
export FABRIC_CA_HOME=./orderers/iaorderer/orderer1/
fabric-ca-client enroll --csr.hosts "orderer1.iaorderer.com" -u http://orderer1.iaorderer.com:secret@localhost:8054 -M tls

export FABRIC_CA_HOME=./peers/iapeer/peer1/
fabric-ca-client enroll --csr.hosts "peer1.iapeer.com" -u http://peer1.iapeer.com:secret@localhost:8054 -M tls

sudo mv orderers/iaorderer/orderer1/tls/keystore/* orderers/iaorderer/orderer1/tls/keystore/server.key

sudo mv peers/iapeer/peer1/tls/keystore/* peers/iapeer/peer1/tls/keystore/server.key
