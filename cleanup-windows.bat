:: removes all CA content + containers for restarting the application
rmdir -r ca
rmdir -r tlsca
docker rm -f insurapp_ca.insurapp.com_1
docker rm -f insurapp_tlsca.insurapp.com_1
docker rm -f InsurApp-Web