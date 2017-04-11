# PrestaShop con Docker

### Imagen para PrestaShop 1.6.1.12
* `1.6.1.12`

## Qué es PrestaShop

PrestaShop es una aplicación libre y gratuita de eCommerce, diseñada para proporcionar la mejor experiencia de compra para los comerciantes y clientes. Está escrito en PHP, es altamente personalizable, soporta todos los servicios de pago más importantes, está traducido en muchos idiomas y está localizado en muchos países, tiene un diseño totalmente responsive, etc.

## Cómo ejecutar esta imagen

Actualmente, la forma más sencilla de ejecutar este contenedor es:
```
docker run -ti --name prestashop16 -p 8080:80 -d oddworldng/prestashop16
```

Abre esta ruta en tu navegador para comenzar la instalación: `http://localhost:8080/prestashop`.

## MySQL - Base de datos

Por seguridad, la base de datos la ejecutamos desde un contenedor Docker siguiendo estos pasos:

* Obtener contenedor MySQL: 

```
docker pull mysql
```

* Desplegar contenedor MySQL:

```
docker run --name mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:latest
```
Ver [más información](https://hub.docker.com/_/mysql/) sobre este contenedor.

## PhpMyAdmin - Configurar la base de datos

Podemos configurar nuestra base de datos mediante PhpMyadmin. Para instalar el contenedor debemos seguir estos pasos:

* Obtener contenedor PhpMyAdmin:

```
docker pull phpmyadmin/phpmyadmin
```

* Desplegar contenedor PhpMyAdmin:

```
docker run --name phpmyadmin -d --link mysql:db -p 8081:80 phpmyadmin/phpmyadmin
```

Ver [más información](https://hub.docker.com/r/phpmyadmin/phpmyadmin/) sobre este contenedor.

## Licencia

Prestashop 1.6 utiliza la licencia [Academic Free License ("AFL") v. 3.0](https://opensource.org/licenses/AFL-3.0)

Consulta [más información](https://www.prestashop.com/en/osl-license) sobre las licencias que utliza Prestashop.

## Documentación

Puedes encontrar la documentación oficial de Prestashop 1.6 (en Español) en el siguiente enlace:

* [PrestaShop 1.6](http://doc.prestashop.com/pages/viewpage.action?pageId=26148899)
