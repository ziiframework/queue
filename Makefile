build:
	@cp -n .env.example .env
	docker-compose pull
	docker-compose build --pull

test: test74
test74:
	docker-compose build --pull php74
	docker-compose run php74 vendor/bin/phpunit --colors=always -v --debug
	docker-compose down

benchmark: benchmark74
benchmark74:
	docker-compose build --pull php74
	docker-compose run php74 tests/yii benchmark/waiting
	docker-compose down

check-cs:
	docker-compose build php74
	docker-compose run php74 php-cs-fixer fix --diff --dry-run
	docker-compose down

clean:
	docker-compose down
	rm -rf tests/runtime/*
	rm -f .php_cs.cache
	rm -rf composer.lock
	rm -rf vendor/

clean-all: clean
	sudo rm -rf tests/runtime/.composer*
