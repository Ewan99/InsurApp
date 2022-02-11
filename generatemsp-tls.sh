						###generate tls msp certs###
export FABRIC_CA_HOME=./roottlsca-admin
fabric-ca-client enroll -u http://admin:1907ed@localhost:8054
##					
fabric-ca-client register --id.name orderer1.insurance.com --id.secret secret --id.type orderer -u http://localhost:8054
##
fabric-ca-client register --id.name peer1.insurance.com --id.secret secret --id.type peer -u http://localhost:8054
##
fabric-ca-client register --id.name admin1.insurance.com --id.secret secret --id.type admin -u http://localhost:8054
##
##
##
fabric-ca-client register --id.name orderer1.garage.com --id.secret secret --id.type orderer -u http://localhost:8054
##
fabric-ca-client register --id.name peer1.garage.com --id.secret secret --id.type peer -u http://localhost:8054
##
fabric-ca-client register --id.name admin1.garage.com --id.secret secret --id.type admin -u http://localhost:8054
##
##
##
export FABRIC_CA_HOME=./orderers/insurance/orderer1/
fabric-ca-client enroll --csr.hosts "orderer1.insurance.com" -u http://orderer1.insurance.com:secret@localhost:8054 -M tls
##
export FABRIC_CA_HOME=./orderers/insurance/peer1/
fabric-ca-client enroll --csr.hosts "peer1.insurance.com" -u http://peer1.insurance.com:secret@localhost:8054 -M tls
##
export FABRIC_CA_HOME=./orderers/insurance/admin1/
fabric-ca-client enroll --csr.hosts "admin1.insurance.com" -u http://admin1.insurance.com:secret@localhost:8054 -M tls
##
export FABRIC_CA_HOME=./orderers/garage/orderer1/
fabric-ca-client enroll --csr.hosts "orderer1.garage.com" -u http://orderer1.garage.com:secret@localhost:8054 -M tls
##
export FABRIC_CA_HOME=./orderers/garage/peer1/
fabric-ca-client enroll --csr.hosts "peer1.garage.com" -u http://peer1.garage.com:secret@localhost:8054 -M tls
##
export FABRIC_CA_HOME=./orderers/garage/admin1/
fabric-ca-client enroll --csr.hosts "admin1.garage.com" -u http://admin1.garage.com:secret@localhost:8054 -M tls