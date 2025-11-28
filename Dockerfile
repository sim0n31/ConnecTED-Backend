# ---------- Build stage ----------
FROM eclipse-temurin:17-jdk-alpine AS builder

WORKDIR /app
COPY . .

RUN chmod +x ./MolinaChirinosTP/mvnw

WORKDIR /app/MolinaChirinosTP
RUN ./mvnw -DskipTests package


# ---------- Run stage ----------
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

COPY --from=builder /app/MolinaChirinosTP/target/*.jar app.jar

ENV SPRING_PROFILES_ACTIVE=prod

# Render mapea el puerto, NO SE DEBE SETEAR PORT MANUAL
EXPOSE 8080

ENTRYPOINT ["java","-jar","/app/app.jar"]
