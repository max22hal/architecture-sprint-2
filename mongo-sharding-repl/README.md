# Настройка MongoDB Sharded Cluster с использованием Docker

Это руководство поможет вам настроить MongoDB Sharded Cluster с использованием Docker и Docker Compose.

## Запуск контейнеров

Для запуска контейнеров выполните следующую команду:

```bash
docker-compose up -d
```

## Запуск конфигурационного сервера

Инициализируй конфиг

```bash
docker exec -it configSrv mongosh --port 27017
```
```bash
rs.initiate(
  {
    _id : "config_server",
       configsvr: true,
    members: [
      { _id : 0, host : "configSrv:27017" }
    ]
  }
);
exit();
```
## Инициализация шардов

Войди в контейнер shard1-1

```bash
docker exec -it shard1-1 mongosh --port 27018
```

Инициализация репликационного набора

```bash
rs.initiate({
  _id: "shard1",
  members: [
    { _id: 0, host: "shard1-1:27018" },
    { _id: 1, host: "shard1-2:27018" },
    { _id: 2, host: "shard1-3:27018" }
  ]
})
exit();
```

Повтори для второго шарда.


```bash
docker exec -it shard2-1 mongosh --port 27019
```

Инициализация репликационного набора

```bash
rs.initiate({
  _id: "shard2",
  members: [
    { _id: 0, host: "shard2-1:27019" },
    { _id: 1, host: "shard2-2:27019" },
    { _id: 2, host: "shard2-3:27019" }
  ]
});
exit();
```

## Добавление шардов в роутер

Добавь шарды в mongos_router:

```bash
docker exec -it mongos_router mongosh --port 27020
```
```bash
sh.addShard("shard1/shard1-1:27018")
sh.addShard("shard1/shard1-2:27018")
sh.addShard("shard1/shard1-3:27018")

sh.addShard("shard2/shard2-1:27019")
sh.addShard("shard2/shard2-2:27019")
sh.addShard("shard2/shard2-3:27019")
```