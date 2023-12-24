echo
echo "###############################"
echo "#### Destroying Containers ####"
echo "###############################"
echo
sudo docker rm -f InsurApp-Web
sudo docker rm -f ca.orderer.insurapp.com
sudo docker rm -f tlsca.orderer.insurapp.com
sudo docker rm -f ca.peer.insurapp.com
sudo docker rm -f tlsca.peer.insurapp.com
sudo docker rm -f orderer1.iaorderer.com
sudo docker rm -f orderer2.iaorderer.com
sudo docker rm -f orderer3.iaorderer.com
sudo docker rm -f peer1.iapeer.com
sudo docker rm -f peer2.iapeer.com
sudo docker rm -f peer3.iapeer.com
sudo docker rm -f cli
echo
echo "####################################"
echo "#### Pruning Volumes and Images ####"
echo "####################################"
echo
echo " ---Volumes"
sudo docker volume rm insurappremake_ca.orderer.insurapp.com -f
sudo docker volume rm insurappremake_ca.peer.insurapp.com -f
sudo docker volume rm insurappremake_orderer1.iaorderer.com -f
sudo docker volume rm insurappremake_orderer2.iaorderer.com -f
sudo docker volume rm insurappremake_orderer3.iaorderer.com -f
sudo docker volume rm insurappremake_peer1.iapeer.com -f
sudo docker volume rm insurappremake_peer2.iapeer.com -f
sudo docker volume rm insurappremake_peer3.iapeer.com -f
sudo docker volume rm insurappremake_tlsca.orderer.insurapp.com -f
sudo docker volume rm insurappremake_tlsca.peer.insurapp.com -f
sudo docker volume prune -f
echo
echo " ---Images"
sudo docker image prune -f
echo
echo "#################################"
echo "#### Deleting Certs and Keys ####"
echo "#################################"
echo
###############################################
sudo rm -rf ca/*
sudo rm -rf tlsca/*
sudo rm -rf admincerts/*
sudo rm -rf channel-artifacts/*
###############################################
sudo rm -rf orderers/iaorderer/msp/admincerts/*
sudo rm -rf orderers/iaorderer/msp/cacerts/*
sudo rm -rf orderers/iaorderer/msp/tlscacerts/*
###############################################
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

sudo rm -rf orderers/iaorderer/orderer2/msp/admincerts/*
sudo rm -rf orderers/iaorderer/orderer2/msp/cacerts/*
sudo rm -rf orderers/iaorderer/orderer2/msp/keystore/*
sudo rm -rf orderers/iaorderer/orderer2/msp/signcerts/*
sudo rm -rf orderers/iaorderer/orderer2/msp/IssuerPublicKey
sudo rm -rf orderers/iaorderer/orderer2/msp/IssuerRevocationPublicKey
sudo rm -rf orderers/iaorderer/orderer2/msp/user/admin/admincerts/*
sudo rm -rf orderers/iaorderer/orderer2/msp/user/admin/cacerts/*
sudo rm -rf orderers/iaorderer/orderer2/msp/user/admin/keystore/*
sudo rm -rf orderers/iaorderer/orderer2/msp/user/admin/signcerts/*
sudo rm -rf orderers/iaorderer/orderer2/msp/user/admin/user/*
sudo rm -rf orderers/iaorderer/orderer2/msp/user/admin/IssuerPublicKey
sudo rm -rf orderers/iaorderer/orderer2/msp/user/admin/IssuerRevocationPublicKey
sudo rm -rf orderers/iaorderer/orderer2/tls/cacerts/*
sudo rm -rf orderers/iaorderer/orderer2/tls/keystore/*
sudo rm -rf orderers/iaorderer/orderer2/tls/signcerts/*
sudo rm -rf orderers/iaorderer/orderer2/tls/user/*
sudo rm -rf orderers/iaorderer/orderer2/tls/IssuerPublicKey
sudo rm -rf orderers/iaorderer/orderer2/tls/IssuerRevocationPublicKey

sudo rm -rf orderers/iaorderer/orderer3/msp/admincerts/*
sudo rm -rf orderers/iaorderer/orderer3/msp/cacerts/*
sudo rm -rf orderers/iaorderer/orderer3/msp/keystore/*
sudo rm -rf orderers/iaorderer/orderer3/msp/signcerts/*
sudo rm -rf orderers/iaorderer/orderer3/msp/IssuerPublicKey
sudo rm -rf orderers/iaorderer/orderer3/msp/IssuerRevocationPublicKey
sudo rm -rf orderers/iaorderer/orderer3/msp/user/admin/admincerts/*
sudo rm -rf orderers/iaorderer/orderer3/msp/user/admin/cacerts/*
sudo rm -rf orderers/iaorderer/orderer3/msp/user/admin/keystore/*
sudo rm -rf orderers/iaorderer/orderer3/msp/user/admin/signcerts/*
sudo rm -rf orderers/iaorderer/orderer3/msp/user/admin/user/*
sudo rm -rf orderers/iaorderer/orderer3/msp/user/admin/IssuerPublicKey
sudo rm -rf orderers/iaorderer/orderer3/msp/user/admin/IssuerRevocationPublicKey
sudo rm -rf orderers/iaorderer/orderer3/tls/cacerts/*
sudo rm -rf orderers/iaorderer/orderer3/tls/keystore/*
sudo rm -rf orderers/iaorderer/orderer3/tls/signcerts/*
sudo rm -rf orderers/iaorderer/orderer3/tls/user/*
sudo rm -rf orderers/iaorderer/orderer3/tls/IssuerPublicKey
sudo rm -rf orderers/iaorderer/orderer3/tls/IssuerRevocationPublicKey
###############################################
sudo rm -rf peers/iapeer/msp/admincerts/*
sudo rm -rf peers/iapeer/msp/cacerts/*
sudo rm -rf peers/iapeer/msp/tlscacerts/*
###############################################
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

sudo rm -rf peers/iapeer/peer2/msp/admincerts/*
sudo rm -rf peers/iapeer/peer2/msp/cacerts/*
sudo rm -rf peers/iapeer/peer2/msp/keystore/*
sudo rm -rf peers/iapeer/peer2/msp/signcerts/*
sudo rm -rf peers/iapeer/peer2/msp/user/admin/admincerts/*
sudo rm -rf peers/iapeer/peer2/msp/user/admin/cacerts/*
sudo rm -rf peers/iapeer/peer2/msp/user/admin/keystore/*
sudo rm -rf peers/iapeer/peer2/msp/user/admin/signcerts/*
sudo rm -rf peers/iapeer/peer2/msp/user/admin/user/*
sudo rm -rf peers/iapeer/peer2/msp/user/admin/IssuerPublicKey
sudo rm -rf peers/iapeer/peer2/msp/user/admin/IssuerRevocationPublicKey
sudo rm -rf peers/iapeer/peer2/msp/IssuerPublicKey
sudo rm -rf peers/iapeer/peer2/msp/IssuerRevocationPublicKey
sudo rm -rf peers/iapeer/peer2/tls/cacerts/*
sudo rm -rf peers/iapeer/peer2/tls/keystore/*
sudo rm -rf peers/iapeer/peer2/tls/signcerts/*
sudo rm -rf peers/iapeer/peer2/tls/user/*
sudo rm -rf peers/iapeer/peer2/tls/IssuerPublicKey
sudo rm -rf peers/iapeer/peer2/tls/IssuerRevocationPublicKey

sudo rm -rf peers/iapeer/peer3/msp/admincerts/*
sudo rm -rf peers/iapeer/peer3/msp/cacerts/*
sudo rm -rf peers/iapeer/peer3/msp/keystore/*
sudo rm -rf peers/iapeer/peer3/msp/signcerts/*
sudo rm -rf peers/iapeer/peer3/msp/user/admin/admincerts/*
sudo rm -rf peers/iapeer/peer3/msp/user/admin/cacerts/*
sudo rm -rf peers/iapeer/peer3/msp/user/admin/keystore/*
sudo rm -rf peers/iapeer/peer3/msp/user/admin/signcerts/*
sudo rm -rf peers/iapeer/peer3/msp/user/admin/user/*
sudo rm -rf peers/iapeer/peer3/msp/user/admin/IssuerPublicKey
sudo rm -rf peers/iapeer/peer3/msp/user/admin/IssuerRevocationPublicKey
sudo rm -rf peers/iapeer/peer3/msp/IssuerPublicKey
sudo rm -rf peers/iapeer/peer3/msp/IssuerRevocationPublicKey
sudo rm -rf peers/iapeer/peer3/tls/cacerts/*
sudo rm -rf peers/iapeer/peer3/tls/keystore/*
sudo rm -rf peers/iapeer/peer3/tls/signcerts/*
sudo rm -rf peers/iapeer/peer3/tls/user/*
sudo rm -rf peers/iapeer/peer3/tls/IssuerPublicKey
sudo rm -rf peers/iapeer/peer3/tls/IssuerRevocationPublicKey
###############################################
sudo rm -rf rootca-admin/msp/cacerts/*
sudo rm -rf rootca-admin/msp/keystore/*
sudo rm -rf rootca-admin/msp/signcerts/*
sudo rm -rf rootca-admin/msp/user/*
sudo rm -rf rootca-admin/msp/IssuerPublicKey
sudo rm -rf rootca-admin/msp/IssuerRevocationPublicKey
###############################################
sudo rm -rf rootca/msp/cacerts/*
sudo rm -rf rootca/msp/keystore/*
sudo rm -rf rootca/msp/signcerts/*
sudo rm -rf rootca/msp/user/*
sudo rm -rf rootca/msp/IssuerPublicKey
sudo rm -rf rootca/msp/IssuerRevocationPublicKey
###############################################
sudo rm -rf roottlsca/msp/cacerts/*
sudo rm -rf roottlsca/msp/keystore/*
sudo rm -rf roottlsca/msp/signcerts/*
sudo rm -rf roottlsca/msp/user/*
sudo rm -rf roottlsca/msp/IssuerPublicKey
sudo rm -rf roottlsca/msp/IssuerRevocationPublicKey
###############################################
sudo rm -rf roottlsca-admin/msp/cacerts/*
sudo rm -rf roottlsca-admin/msp/keystore/*
sudo rm -rf roottlsca-admin/msp/signcerts/*
sudo rm -rf roottlsca-admin/msp/user/*
sudo rm -rf roottlsca-admin/msp/IssuerPublicKey
sudo rm -rf roottlsca-admin/msp/IssuerRevocationPublicKey
###############################################
sudo rm -rf rootca-admin-orderer/msp/cacerts/*
sudo rm -rf rootca-admin-orderer/msp/keystore/*
sudo rm -rf rootca-admin-orderer/msp/signcerts/*
sudo rm -rf rootca-admin-orderer/msp/user/*
sudo rm -rf rootca-admin-orderer/msp/IssuerPublicKey
sudo rm -rf rootca-admin-orderer/msp/IssuerRevocationPublicKey
###############################################
sudo rm -rf roottlsca-admin-orderer/msp/cacerts/*
sudo rm -rf roottlsca-admin-orderer/msp/keystore/*
sudo rm -rf roottlsca-admin-orderer/msp/signcerts/*
sudo rm -rf roottlsca-admin-orderer/msp/user/*
sudo rm -rf roottlsca-admin-orderer/msp/IssuerPublicKey
sudo rm -rf roottlsca-admin-orderer/msp/IssuerRevocationPublicKey
###############################################
sudo rm -rf rootca-admin-peer/msp/cacerts/*
sudo rm -rf rootca-admin-peer/msp/keystore/*
sudo rm -rf rootca-admin-peer/msp/signcerts/*
sudo rm -rf rootca-admin-peer/msp/user/*
sudo rm -rf rootca-admin-peer/msp/IssuerPublicKey
sudo rm -rf rootca-admin-peer/msp/IssuerRevocationPublicKey
###############################################
sudo rm -rf roottlsca-admin-peer/msp/cacerts/*
sudo rm -rf roottlsca-admin-peer/msp/keystore/*
sudo rm -rf roottlsca-admin-peer/msp/signcerts/*
sudo rm -rf roottlsca-admin-peer/msp/user/*
sudo rm -rf roottlsca-admin-peer/msp/IssuerPublicKey
sudo rm -rf roottlsca-admin-peer/msp/IssuerRevocationPublicKey
###############################################
#sudo rm -rf chaincode/go.mod
#sudo rm -rf chaincode/go.sum
#sudo rm -rf chaincode/vendor
sudo rm -rf chaincode/chaincode.tar.gz
###############################################
echo " Certs and Keys deleted"
echo
echo "##########################"
echo "#### Finished Destroy ####"
echo "##########################"
echo