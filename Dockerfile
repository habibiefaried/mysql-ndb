FROM mysql/mysql-cluster:8.0.22-1.1.18-cluster

COPY my.cnf /etc/my.cnf
COPY mysql-cluster.cnf /etc/mysql-cluster.cnf
RUN chmod 644 /etc/my.cnf
RUN chmod 644 /etc/mysql-cluster.cnf