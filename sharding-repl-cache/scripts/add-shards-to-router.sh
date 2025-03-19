#!/bin/bash

###
# Добавляем шарды в роутер
###
docker compose exec -T mongos_router mongosh --port 27029 --quiet <<EOF
sh.addShard("shard1/shard1-1:27018")
sh.addShard("shard1/shard1-2:27018")
sh.addShard("shard1/shard1-3:27018")

sh.addShard("shard2/shard2-1:27019")
sh.addShard("shard2/shard2-2:27019")
sh.addShard("shard2/shard2-3:27019")
EOF
