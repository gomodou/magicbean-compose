APP_NAME="modou"
# Build the container
build: ## Build the container
	docker-compose down && docker-compose --env-file ${CURDIR}/magicbean.env up --build
## docker build --rm -t $(APP_NAME) .

up: ## run container
	docker-compose down && docker-compose --env-file ./.env.prod -f docker-compose.aliyun.yaml up -d

per:
	docker-compose -f docker-compose.persistent.yaml up -d
perstop:
	docker-compose -f docker-compose.persistent.yaml stop

stop: ## stop container
	docker-compose stop

down: ## stop container
	docker-compose --env-file ./.env.prod -f docker-compose.aliyun.yaml down

clean:
	docker-compose down
	docker image prune
	rm -rf pgdata rabbitmq
	rm -rf backend/logs
	rm -rf backend/magicbean
	rm -rf pipeline/hykpi_workspace
