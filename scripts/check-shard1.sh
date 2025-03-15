###
# Проверка первого шарда
###

 docker exec -it shard1 mongosh --port 27018 <<EOF
 use somedb;
 db.helloDoc.countDocuments();
 EOF