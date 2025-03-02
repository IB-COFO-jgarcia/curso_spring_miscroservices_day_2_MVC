# Día 2

---

## AnnotationConfigApplicationContext

- eliminamos ClassPathXmlApplicationContext de app para cambiarlo por AnnotationConfigApplicationContext
- eliminamos todas las referenicias a anotaciones @Componet y @Scope de
    - Employee
    - Person
    - Address
- Creamos ApplicationConfig y agregamos la anotación @Bean para
    - Employee
    - Person
    - Address
    - Wisher a este no se lo ponemos en cambio agrega @Component en su clase
        - y además agregamos @ComponentScan(basePackages = "com.coforge.firstmvnapp.beans") en ApplicationConfig
- Dejo en Person sobre el atributo Address la anotacion @Autowired y puedo utilizar @Qualifier("add1") para definir uno de los dos bean de tipo Address

---

- XML Configuration
- Java Based Configuration
- Annotations === XML + annotation
    - Javaconfig + annotation

---

- Spring JDBC
- Spring MVC

## Spring MVC

- Crea un proyecto utilizando el archetype:
  - `org.apache.maven.archetypes:maven-archetype-webapp`

### fichero spring-servlet.xml

- Se crea el fichero
  - src/main/webapp/WEB-INF/spring-servlet.xml
    - define beans y sus url
    - crea context:componet-scan
    - bean para definir como se van a resolver las vistas
      - clase `org.springframework.web.servlet.view.InternalResourceViewResolver`
      - properties `prefix` y `suffix`

#### version 1

```xml
<?xml version="1.0" encoding="UTF-8" ?>

<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
            http://www.springframework.org/schema/beans/spring-beans.xsd
            http://www.springframework.org/schema/context
            http://www.springframework.org/schema/context/spring-context.xsd">

    <context:component-scan base-package="com.coforge.controller"></context:component-scan>

    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver" name="vieResolver">
        <property name="prefix" value="/WEB-INF/views/"/>
        <property name="suffix" value=".jsp"/>
    </bean>

</beans>
```

#### version 2

- se agrega xmlns:p que permite definir los properties como atributos en el bean
- se simplifica así
      - `p:name="value"`

```xml
<?xml version="1.0" encoding="UTF-8" ?>

<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:p="http://www.springframework.org/schema/p"
       xmlns:context="http://www.springframework.org/schema/context"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
            http://www.springframework.org/schema/beans/spring-beans.xsd
            http://www.springframework.org/schema/context
            http://www.springframework.org/schema/context/spring-context.xsd">

    <context:component-scan base-package="com.coforge.controller"></context:component-scan>

    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver"
          name="vieResolver" p:prefix="/WEB-INF/views/" p:suffix=".jsp" />

</beans>
```

### fichero web.xml

- Se rellena el web.xml, definiendo un `servlet`, y `servlet-mapping`
  - el `servlet-class` es una clase Dispatcher de Springframework
    - `org.springframework.web.servlet.DispatcherServlet`

```xml
  <servlet>
    <servlet-name>spring</servlet-name>
    <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
  </servlet>

  <servlet-mapping>
    <servlet-name>spring</servlet-name>
    <url-pattern>/</url-pattern>
  </servlet-mapping>
```

### fichero pom.xml

- Requiere agregar dependenicias en el `pom.xml` para que resuelva

```xml
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-webmvc</artifactId>
      <version>5.3.18</version>
    </dependency>
    <dependency>
      <groupId>jstl</groupId>
      <artifactId>jstl</artifactId>
      <version>1.2</version>
    </dependency>
    <dependency>
      <groupId>javax.servlet</groupId>
      <artifactId>javax.servlet-api</artifactId>
      <version>4.0.1</version>
      <scope>provided</scope>
    </dependency>
```

### Logica de Negocio

- Crea un par de controladores en el package `com.coforge.controller`
  - HomeController
  - ContactController

- Crea las vistas dentro de la subcarperta `WEB-INF\views`
  - esto se resuelve en el `prefix` del fichero `spring.servlet.xml`
  - index.jsp
  - about.jsp
  - help.jsp
  - contact.jsp
    - success.jsp

#### fichero HomeController

- con anotaciones agrega a la clase `@Controller` y `@RequestMapping("/users")`
  - esto se resuelve con el tag `<context:component-scan base-package="com.coforge.controller"></context:component-scan>` del fichero `spring-servlet.jsp`
  - la URL será [http://localhost:8080/SpringMVC/users](http://localhost:8080/SpringMVC/users)
- Se crean tres métodos
  - `home`
  - `about`
  - `help`

##### método home

- Tiene una anotacion `@RequestMapping(path = "\home",  method = RequestMethod.GET)` con dos argumentos
  - si solo tiene un argumento es una cadena que corresponde al path implícitamente, pero si tiene dos, hay que ponerlo explícitamente
  - el segundo argumento si no se pone implícitamente es methos = RequestMethod.GET, pero existen otros valores
  - el propio método recibe un argumento `Model` que pertenece a `org.springframework.ui.Model;`
    - se utiliza para agregar atributos a la request que serán consumidos por la vista (jsp)
    - retorna la cadena `index` que se resolverá como la vista que está en `WEB-INF\views\index.jsp`

> [!NOTE]
> ```java
> public enum RequestMethod {
>    GET,
>    HEAD,
>    POST,
>    PUT,
>    PATCH,
>    DELETE,
>    OPTIONS,
>    TRACE;
>
>    private RequestMethod() {
>    }
> ```
>
> ##### Verbos
>
> A continuación, te presento una descripción de cada uno de los métodos HTTP y su uso común:
>
> ###### GET
>
> - Uso: Obtener recursos existentes.
> - Ejemplo: http://example.com/users para obtener la lista de usuarios.
> - Características:
>   - No modifica el estado del servidor.
>   - No envía datos en el cuerpo de la solicitud.
>   - El servidor devuelve los datos en el cuerpo de la respuesta.
>
> ###### HEAD
>
> - Uso: Obtener información sobre un recurso sin obtener el recurso en sí.
> - Ejemplo: http://example.com/users/123 para obtener la información del usuario con ID 123 sin obtener el usuario en sí.
> - Características:
>   - No modifica el estado del servidor.
>   - No envía datos en el cuerpo de la solicitud.
>   - El servidor devuelve la información solicitada en la respuesta, pero sin el cuerpo del recurso.
>
> ###### POST
>
> - Uso: Crear un nuevo recurso.
> - Ejemplo: http://example.com/users para crear un nuevo usuario.
> - Características:
>   - Modifica el estado del servidor.
>   - Envía datos en el cuerpo de la solicitud.
>   - El servidor crea un nuevo recurso y devuelve la respuesta.
>
> ###### PUT
>
> - Uso: Actualizar un recurso existente.
> - Ejemplo: http://example.com/users/123 para actualizar el usuario con ID 123.
> - Características:
>   - Modifica el estado del servidor.
>   - Envía datos en el cuerpo de la solicitud.
>   - El servidor actualiza el recurso existente y devuelve la respuesta.
>
> ###### PATCH
>
> - Uso: Actualizar parte de un recurso existente.
> - Ejemplo: http://example.com/users/123 para actualizar solo algunos campos del usuario con ID 123.
> - Características:
>   - Modifica el estado del servidor.
>   - Envía datos en el cuerpo de la solicitud.
>   - El servidor actualiza solo los campos especificados y devuelve la respuesta.
>
> ###### DELETE
>
> - Uso: Eliminar un recurso existente.
> - Ejemplo: http://example.com/users/123 para eliminar el usuario con ID 123.
> - Características:
>   - Modifica el estado del servidor.
>   - No envía datos en el cuerpo de la solicitud.
>   - El servidor elimina el recurso existente y devuelve la respuesta.
>
> ###### OPTIONS
>
> - Uso: Obtener información sobre los métodos que se pueden utilizar para interactuar con un recurso.
> - Ejemplo: http://example.com/users para obtener la lista de métodos que se pueden utilizar para interactuar con la lista de usuarios.
> - Características:
>   - No modifica el estado del servidor.
>   - No envía datos en el cuerpo de la solicitud.
>   - El servidor devuelve la lista de métodos que se pueden utilizar en la respuesta.
>
> ###### TRACE
>
> - Uso: Realizar una solicitud de seguimiento para obtener información sobre la ruta que se sigue para llegar a un recurso.
> - Ejemplo: http://example.com/users para obtener la ruta que se sigue para llegar a la lista de usuarios.
> - Características:
>   - No modifica el estado del servidor.
>   - No envía datos en el cuerpo de la solicitud.
>   - El servidor devuelve la ruta que se sigue en la respuesta.
>
>
> - En resumen, cada método HTTP tiene un uso específico y características únicas. Al entender cada uno de ellos, puedes diseñar aplicaciones web más eficientes y escalables.

##### método about

- Tiene una anotacion `@RequestMapping(path = "\about")` solo un argumento
  - si solo tiene un argumento es una cadena que corresponde al path implícitamente, pero si tiene dos, hay que ponerlo explícitamente
  - no tiene segundo argumento por lo que implícitamente es methos = RequestMethod.GET
  - retorna la cadena `about` que se resolverá como la vista que está en `WEB-INF\views\about.jsp`

##### método help

- Tiene una anotacion `@RequestMapping(path = "\help")` solo un argumento
  - si solo tiene un argumento es una cadena que corresponde al path implícitamente, pero si tiene dos, hay que ponerlo explícitamente
  - no tiene segundo argumento por lo que implícitamente es methos = RequestMethod.GET
  - retorna un objeto `ModelAndView` que pertenece a `org.springframework.web.servlet.ModelAndView`
    - se le añaden objetos con nombre y valor
      - ejemplo: `modelAndView.addObject("name", "José Macías");`
    - se establece la vista: `modelAndView.setViewName("help");`
    - que se resolverá como la vista que está en `WEB-INF\views\help.jsp`

#### fichero ContacController

- con anotaciones agrega a la clase `@Controller` y `@RequestMapping("/contact")`
  - esto se resuelve con el tag `<context:component-scan base-package="com.coforge.controller"></context:component-scan>` del fichero `spring-servlet.jsp`
  - la URL será [http://localhost:8080/SpringMVC/contact](http://localhost:8080/SpringMVC/contact)
- Se crean dos métodos
  - `showForm`
  - `handleForm`

##### método showForm

- Tiene una anotacion `@RequestMapping(path = "\contact")` solo un argumento
  - si solo tiene un argumento es una cadena que corresponde al path implícitamente, pero si tiene dos, hay que ponerlo explícitamente
  - no tiene segundo argumento por lo que implícitamente es methos = RequestMethod.GET
  - retorna la cadena `contact` que se resolverá como la vista que está en `WEB-INF\views\contact.jsp`

##### método handleForm

- Tiene una anotacion `@RequestMapping(path = "\processform",  method = RequestMethod.POST)` con dos argumentos
  - si solo tiene un argumento es una cadena que corresponde al path implícitamente, pero si tiene dos, hay que ponerlo explícitamente
  - el segundo argumento si no se pone implícitamente es methos = RequestMethod.GET, pero existen otros valores
  - el propio método recibe dos argumentos
    - `@ModelAttribute` que pertenece a `org.springframework.web.bind.annotation.ModelAttribute;` es de tipo User
      - recibe un objeto User cargago
    - `Model` que pertenece a `org.springframework.ui.Model;`
      - se utiliza para agregar atributos a la request que serán consumidos por la vista (jsp)
      - retorna la cadena `success` que se resolverá como la vista que está en `WEB-INF\views\success.jsp`

#### fichero index.jsp

- define que es una pagina html y con un juego de caracteres
  - `<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>`
  - Utiliza scriplet de jsp puro para componer las partes de valores del servidor
    - `<% codigo %>`
    - `<%=variable%>`
 
#### fichero about.jsp

- define que es una pagina html y con un juego de caracteres
  - `<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>`

 
#### fichero help.jsp

- define que es una pagina html y con un juego de caracteres
- `<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>`
- define el uso de jstl del core 
  - con esto puede hacer un bucle 
    - `<c:forEach var="item" items="${marks}">`
- define el uso del jstl de EL (Exprexion Languaje)
  - se puede definir el uso de variables más fácilmente
    - `<p>Name is : ${name}</p>`

#### fichero help.jsp

- define que es una pagina html y con un juego de caracteres
  - `<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>`
- importa los estilos y el js de bootstrap
- crea un formulario, con dos cajas de texto y un boton sumbit
  - el formulario tiene el `action` `processform` de typo `POST`
    - `<form action="processform" method="post">`
  - los textos
    - `<input type="text" class ="form-control" id="formGroupExampleInput" placeholder="Enter User Name" name="userName">`
    - `<input type="email" class ="form-control" id="formGroupExampleInput2" placeholder="Enter Mail" name="email">`
  - El boton
    - `<button type="submit" class="btn btn-success">sing in</button>`

#### fichero success.jsp

- define que es una pagina html y con un juego de caracteres
- `<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>`
- define el uso del jstl de EL (Exprexion Languaje)
  - se puede definir el uso de variables más fácilmente
    - `<p>Name is : ${user.userName}</p>`

#### fichero User.java

- El tipico bean que tiene 2 atributos userName y email
  - con dos constructores
  - con getter y setter 
  - con toString