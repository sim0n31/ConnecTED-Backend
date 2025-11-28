# ---------- Build stage ----------
FROM eclipse-temurin:17-jdk-alpine AS builder

WORKDIR /app

# Copiar todo el proyecto (incluye pom.xml y subcarpetas)
COPY . .

# Dar permisos al wrapper
RUN chmod +x ./MolinaChirinosTP/mvnw

# Construir el JAR usando la carpeta correcta
WORKDIR /app/MolinaChirinosTP
RUN ./mvnw -DskipTests package


# ---------- Run stage ----------
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copiar el JAR generado desde el builder
COPY --from=builder /app/MolinaChirinosTP/target/*.jar app.jar

# Activar perfil prod
ENV SPRING_PROFILES_ACTIVE=prod

EXPOSE 8080

ENTRYPOINT ["java","-jar","/app/app.jar"]
