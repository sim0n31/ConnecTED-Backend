# ---------- Build stage ----------
FROM eclipse-temurin:17-jdk-alpine AS builder

WORKDIR /app

# Copiar todo el proyecto
COPY . .

# Dar permisos al mvnw (Render usa Linux)
RUN chmod +x mvnw

# Construir el .jar sin tests
RUN ./mvnw -DskipTests package


# ---------- Run stage ----------
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copiar el jar generado desde el builder
COPY --from=builder /app/target/*.jar app.jar

# Usar perfil por defecto
ENV SPRING_PROFILES_ACTIVE=default

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
