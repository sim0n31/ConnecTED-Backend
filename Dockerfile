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

# 🔥 PUERTO RENDER
ENV PORT=10000
EXPOSE 10000

ENTRYPOINT ["java","-jar","/app/app.jar"]
