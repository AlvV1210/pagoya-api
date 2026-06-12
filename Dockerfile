# =========================================================
#  Stage 1: build — compila el JAR con Maven y JDK 21
# =========================================================
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /workspace

# Cache de dependencias: copiamos solo el pom primero
COPY pom.xml .
RUN mvn -B -q dependency:go-offline

# Ahora sí, copiamos el código y empaquetamos
COPY src ./src
RUN mvn -B -q clean package -DskipTests

# =========================================================
#  Stage 2: runtime — sólo JRE 21, imagen final liviana
# =========================================================
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# ⚠️ REEMPLAZA "pagoya-0.0.1-SNAPSHOT.jar" por el nombre del JAR
# que genera TU proyecto. Ese nombre se arma con los valores
# <artifactId> y <version> de tu pom.xml:
#
#     target/<artifactId>-<version>.jar
#
# Ejemplos:
#   - artifactId=pagoya, version=0.0.1-SNAPSHOT  → pagoya-0.0.1-SNAPSHOT.jar
#   - artifactId=bookstore, version=1.0.0        → bookstore-1.0.0.jar
#
# Si no estás seguro, corre `mvn clean package` localmente y mira
# qué archivo .jar aparece dentro de la carpeta target/.
COPY --from=build /workspace/target/pagoya-0.0.1-SNAPSHOT.jar app.jar

# Render asigna el puerto en la variable PORT en runtime;
# EXPOSE es informativo, no fija el puerto real.
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
