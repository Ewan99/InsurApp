export FABRIC_CA_HOME=./rootca-admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7054

fabric-ca-client register --id.name orderer1.iaorderer.com --id.secret secret --id.type orderer -u http://localhost:7054
fabric-ca-client register --id.name peer1.iapeer.com --id.secret secret --id.type peer -u http://localhost:7054
fabric-ca-client register --id.name admin.iaorderer.com --id.secret adminpw --id.type admin -u http://localhost:7054
fabric-ca-client register --id.name admin.iapeer.com --id.secret adminpw --id.type admin -u http://localhost:7054

export FABRIC_CA_HOME=./orderers/iaorderer/orderer1/
fabric-ca-client enroll --csr.hosts "orderer1.iaorderer.com" -u http://orderer1.iaorderer.com:secret@localhost:7054

export FABRIC_CA_HOME=./peers/iapeer/peer1/
fabric-ca-client enroll --csr.hosts "peer1.iapeer.com" -u http://peer1.iapeer.com:secret@localhost:7054

export FABRIC_CA_HOME=./orderers/iaorderer/orderer1/msp/user/
fabric-ca-client enroll --csr.hosts "admin.iaorderer.com" -u http://admin.iaorderer.com:adminpw@localhost:7054 -M admin

export FABRIC_CA_HOME=./peers/iapeer/peer1/msp/user/
fabric-ca-client enroll --csr.hosts "admin.iapeer.com" -u http://admin.iapeer.com:adminpw@localhost:7054 -M admin