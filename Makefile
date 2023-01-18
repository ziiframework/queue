build:
	@cp -n .env.example .env
	docker-compose pull
	docker-compose build --pull

test: test74
test74:
	docker-compose build --pull php74
	docker-compose run php74 vendor/bin/phpunit --colors=always -v --debug
	docker-compose down

test: test80
test80:
	docker-compose build --pull php80
	docker-compose run php80 vendor/bin/phpunit --colors=always -v --debug
	docker-compose down

test: test81
test81:
	docker-compose build --pull php81
	docker-compose run php81 vendor/bin/phpunit --colors=always -v --debug
	docker-compose down

benchmark: benchmark74
benchmark74:
	docker-compose build --pull php74
	docker-compose run php74 tests/yii benchmark/waiting
	docker-compose down

benchmark: benchmark80
benchmark80:
	docker-compose build --pull php80
	docker-compose run php80 tests/yii benchmark/waiting
	docker-compose down

benchmark: benchmark81
benchmark81:
	docker-compose build --pull php81
	docker-compose run php81 tests/yii benchmark/waiting
	docker-compose down

clean:
	docker-compose down
	rm -rf tests/runtime/*
	rm -f .php_cs.cache
	rm -rf composer.lock
	rm -rf vendor/

clean-all: clean
	sudo rm -rf tests/runtime/.composer*
