CREATE USER wisecost@'%' IDENTIFIED BY 'Wisecost~';
GRANT ALL ON storage.* TO wisecost@'%';
GRANT ALL ON wisecost.* TO wisecost@'%';