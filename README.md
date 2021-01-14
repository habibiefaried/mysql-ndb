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

# Benchmarking

1. Install https://github.com/akopytov/sysbench
2. Create database "sysbench"
3. Go to /usr/share/sysbench and execute script

```
/usr/share/sysbench# ls
bulk_insert.lua  oltp_delete.lua  oltp_point_select.lua  oltp_read_write.lua    oltp_update_non_index.lua  select_random_points.lua  tests
oltp_common.lua  oltp_insert.lua  oltp_read_only.lua     oltp_update_index.lua  oltp_write_only.lua        select_random_ranges.lua
root@vmi483775:/usr/share/sysbench# sysbench oltp_read_write.lua --table-size=2000000 --num-threads=1 --rand-type=uniform --db-driver=mysql --mysql-db=sysbench --mysql-user=root --mysql-password=rootpass --mysql-host=127.0.0.1 prepare
sysbench 1.0.20 (using bundled LuaJIT 2.1.0-beta2)

Creating table 'sbtest1'...
Inserting 2000000 records into 'sbtest1'
```

4. Run Sysbench

```
# sysbench oltp_read_write.lua --table-size=2000000 --num-threads=1 --rand-type=uniform --db-driver=mysql --mysql-db=sysbench --mysql-user=root --mysql-password=rootpass --mysql-host=127.0.0.1 run

SQL statistics:
    queries performed:
        read:                            22225
        write:                           0
        other:                           0
        total:                           22225
    transactions:                        22225  (2209.39 per sec.)
    queries:                             22225  (2209.39 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          10.0584s
    total number of events:              22225

Latency (ms):
         min:                                    0.43
         avg:                                   45.12
         max:                                  470.07
         95th percentile:                      132.49
         sum:                              1002683.20

Threads fairness:
    events (avg/stddev):           222.2500/16.41
    execution time (avg/stddev):   10.0268/0.01
```

5. Cleanup

```
sysbench oltp_read_write.lua --table-size=2000000 --num-threads=1 --rand-type=uniform --db-driver=mysql --mysql-db=sysbench --mysql-user=root --mysql-password=rootpass --mysql-host=127.0.0.1 cleanup
```
