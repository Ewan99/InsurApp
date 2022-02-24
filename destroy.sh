sudo docker rm -f insurappremake_ca.insurapp.com_1
sudo docker rm -f insurappremake_tlsca.insurapp.com_1
sudo docker rm -f insurappremake_orderer1.iaorderer.com_1
sudo docker rm -f peer1.iapeer.com
sudo docker rm -f cli

sudo rm -rf ca/*
sudo rm -rf tlsca/*
sudo rm -rf admincerts/*
sudo rm -rf channel-artifacts/*

sudo rm -rf orderers/iaorderer/msp/admincerts/*
sudo rm -rf orderers/iaorderer/msp/cacerts/*
sudo rm -rf orderers/iaorderer/msp/tlscacerts/*
sudo rm -rf orderers/iaorderer/orderer1/msp/admincerts/*
sudo rm -rf orderers/iaorderer/orderer1/msp/cacerts/*
sudo rm -rf orderers/iaorderer/orderer1/msp/keystore/*
sudo rm -rf orderers/iaorderer/orderer1/msp/signcerts/*
sudo rm -rf orderers/iaorderer/orderer1/msp/IssuerPublicKey
sudo rm -rf orderers/iaorderer/orderer1/msp/IssuerRevocationPublicKey
sudo rm -rf orderers/iaorderer/orderer1/msp/user/admin/admincerts/*
sudo rm -rf orderers/iaorderer/orderer1/msp/user/admin/cacerts/*
sudo rm -rf orderers/iaorderer/orderer1/msp/user/admin/keystore/*
sudo rm -rf orderers/iaorderer/orderer1/msp/user/admin/signcerts/*
sudo rm -rf orderers/iaorderer/orderer1/msp/user/admin/user/*
sudo rm -rf orderers/iaorderer/orderer1/msp/user/admin/IssuerPublicKey
sudo rm -rf orderers/iaorderer/orderer1/msp/user/admin/IssuerRevocationPublicKey
sudo rm -rf orderers/iaorderer/orderer1/tls/cacerts/*
sudo rm -rf orderers/iaorderer/orderer1/tls/keystore/*
sudo rm -rf orderers/iaorderer/orderer1/tls/signcerts/*
sudo rm -rf orderers/iaorderer/orderer1/tls/user/*
sudo rm -rf orderers/iaorderer/orderer1/tls/IssuerPublicKey
sudo rm -rf orderers/iaorderer/orderer1/tls/IssuerRevocationPublicKey

sudo rm -rf peers/iapeer/msp/admincerts/*
sudo rm -rf peers/iapeer/msp/cacerts/*
sudo rm -rf peers/iapeer/msp/tlscacerts/*
sudo rm -rf peers/iapeer/peer1/msp/admincerts/*
sudo rm -rf peers/iapeer/peer1/msp/cacerts/*
sudo rm -rf peers/iapeer/peer1/msp/keystore/*
sudo rm -rf peers/iapeer/peer1/msp/signcerts/*
sudo rm -rf peers/iapeer/peer1/msp/user/admin/admincerts/*
sudo rm -rf peers/iapeer/peer1/msp/user/admin/cacerts/*
sudo rm -rf peers/iapeer/peer1/msp/user/admin/keystore/*
sudo rm -rf peers/iapeer/peer1/msp/user/admin/signcerts/*
sudo rm -rf peers/iapeer/peer1/msp/user/admin/user/*
sudo rm -rf peers/iapeer/peer1/msp/user/admin/IssuerPublicKey
sudo rm -rf peers/iapeer/peer1/msp/user/admin/IssuerRevocationPublicKey
sudo rm -rf peers/iapeer/peer1/msp/IssuerPublicKey
sudo rm -rf peers/iapeer/peer1/msp/IssuerRevocationPublicKey
sudo rm -rf peers/iapeer/peer1/tls/cacerts/*
sudo rm -rf peers/iapeer/peer1/tls/keystore/*
sudo rm -rf peers/iapeer/peer1/tls/signcerts/*
sudo rm -rf peers/iapeer/peer1/tls/user/*
sudo rm -rf peers/iapeer/peer1/tls/IssuerPublicKey
sudo rm -rf peers/iapeer/peer1/tls/IssuerRevocationPublicKey

sudo rm -rf rootca-admin/msp/cacerts/*
sudo rm -rf rootca-admin/msp/keystore/*
sudo rm -rf rootca-admin/msp/signcerts/*
sudo rm -rf rootca-admin/msp/user/*
sudo rm -rf rootca-admin/msp/IssuerPublicKey
sudo rm -rf rootca-admin/msp/IssuerRevocationPublicKey

sudo rm -rf roottlsca-admin/msp/cacerts/*
sudo rm -rf roottlsca-admin/msp/keystore/*
sudo rm -rf roottlsca-admin/msp/signcerts/*
sudo rm -rf roottlsca-admin/msp/user/*
sudo rm -rf roottlsca-admin/msp/IssuerPublicKey
sudo rm -rf roottlsca-admin/msp/IssuerRevocationPublicKey