docker build -t docker-insurapp .
docker run --name InsurApp --network=host -p 3080:3080 -d docker-insurapp
docker-compose -f docker-compose-ca.yaml up -d