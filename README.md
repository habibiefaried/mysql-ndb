# Description
MySQL NDB Cluster with 2 ndb, 2 management and 2 MySQLD API. Plus phpmyadmin

# MySQL Cluster test

```
# docker exec -it mysql-tester ndb_mgm
-- NDB Cluster -- Management Client --
ndb_mgm> show
Connected to Management Server at: mysql-manager-1:1186
Cluster Configuration
---------------------
[ndbd(NDB)]     2 node(s)
id=11   @172.18.0.3  (mysql-8.0.22 ndb-8.0.22, Nodegroup: 0, *)
id=12   @172.18.0.7  (mysql-8.0.22 ndb-8.0.22, Nodegroup: 0)

[ndb_mgmd(MGM)] 2 node(s)
id=1    @172.18.0.9  (mysql-8.0.22 ndb-8.0.22)
id=2    @172.18.0.8  (mysql-8.0.22 ndb-8.0.22)

[mysqld(API)]   2 node(s)
id=21   @172.18.0.5  (mysql-8.0.22 ndb-8.0.22)
id=22   @172.18.0.4  (mysql-8.0.22 ndb-8.0.22)
```

# Add remote root login

```
# docker exec -it mysql-server-1 bash
bash-4.2# mysql -u root -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 11
Server version: 8.0.22-cluster MySQL Cluster Community Server - GPL

mysql> CREATE USER 'root'@'%' IDENTIFIED BY 'rootpass';
mysql> CREATE USER 'root'@'%' IDENTIFIED BY 'rootpass';
Query OK, 0 rows affected (0.03 sec)

mysql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
Query OK, 0 rows affected (0.16 sec)
```

