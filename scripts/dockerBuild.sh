flutter build web 
PACKAGE_NAME="ip-addr-flutter"
docker build -t nexus-docker-internal.shultzlab.com/shultztom/$PACKAGE_NAME:latest .
docker push nexus-docker-internal.shultzlab.com/shultztom/$PACKAGE_NAME:latest
echo 'Done pushing image'