# --- Этап 1: Сборка артефакта ---
	FROM maven:3.9.6-eclipse-temurin-17 AS build
	WORKDIR /app
	COPY pom.xml .
	RUN mvn dependency:go-offline -B
	COPY src ./src
	RUN mvn clean package -DskipTests
	
	# --- Этап 2: Финальный легковесный образ ---
	FROM eclipse-temurin:17-jre
	WORKDIR /app
	
	# Создаем безопасного системного пользователя и папку для постоянных логов
	RUN groupadd -r spring && useradd -r -g spring spring \
		&& mkdir ./logs && chown spring:spring ./logs
	
	USER spring:spring
	
	VOLUME /tmp
	
	# Копируем JAR-файл из этапа сборки
	COPY --from=build --chown=spring:spring /app/target/*.jar order-service.jar
	
	EXPOSE 8080
	
	ENTRYPOINT ["java", "-jar", "order-service.jar"]
	