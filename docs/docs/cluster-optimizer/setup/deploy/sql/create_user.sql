CREATE USER optimizer@'%' IDENTIFIED BY 'Optimizer~';
GRANT ALL ON optimizer.* TO optimizer@'%';