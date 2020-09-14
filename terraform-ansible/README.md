# Terraform SRE POC

Dentro de este proyecto se encuentra la carpeta con el código de Terraform y Ansible

- Utilizamos Terraform para el aprovisionamiento de la infraestructura en AWS, eso incluye :
  VPC, subnets
  security  groups
  balanceador de carga
  registros DNS
  nat gateway
  internet gateway
  ec2 instances
  RDS PostgreSQL
  EFS y dos puntos de montaje

- Utilizamos ansible para realizar la configuración de las máquinas virtuales, en este ejercicio se asume que el servidor desde donde se ejecuta
  ansible está dentro de la VPC, porque el tráfico desde internet no llegará al 22; de todas formas lo permitimos en el SG de las instancias WordPress.



## Usos

El uso básico es el siguiente:

- Para Terraform:
  Agregar las credenciales de AWS como variables de entorno, con aws configure, en la ruta HOME/.aws/credentials o en el archivo de conf del provider.
  Ejecutar  `terraform init`
  Ejecutar  `terraform plan y validar la salida`
  Ejecutar  `terraform apply`
  Con esos tenemos lista la infraestructura necesaria

- Para Ansible:
  modificar el archivo host y agregar las ips de los nodos
  en el archivo `default.yml` de vars debemos cambiar el postgres_host_endpoint por el endpoint de nuestro RDS PostgreSQL
  en http_host agregar nuestro registro DNS
  Luego ejecutamos `ansible-playbook -i hosts site.yml --key-file "~/.ssh/id_rsa"`
