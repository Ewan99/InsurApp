docker start cli
docker start ca.peer.insurapp.com
docker start tlsca.peer.insurapp.com
docker start ca.orderer.insurapp.com
docker start tlsca.orderer.insurapp.com
sleep 10
docker start peer1.iapeer.com
docker start peer2.iapeer.com
docker start peer3.iapeer.com
docker start orderer1.iaorderer.com
docker start orderer2.iaorderer.com
docker start orderer3.iaorderer.com
