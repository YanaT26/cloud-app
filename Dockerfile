# Etapa 1: Build Gradle
FROM gradle:8.0.2-jdk17 AS build
WORKDIR /app

# Copierea fișierelor Gradle și surselor
COPY . .

# Construirea aplicației
RUN gradle build --no-daemon

# Etapa 2: Imagine pentru rularea aplicației
FROM openjdk:17-jdk-slim
WORKDIR /app

# Copiem doar fișierul .jar din build-ul anterior
COPY --from=build /app/build/libs/*.jar app.jar

# Portul pe care aplicația va rula
EXPOSE 8080

# Comanda de pornire a aplicației
CMD ["java", "-jar", "app.jar"]
