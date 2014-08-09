rmi:
	docker rmi keyvanfatehi/strider-docker-slave 2>&1 > /dev/null

build:
	sudo docker build -t keyvanfatehi/strider-docker-slave .

test: build
	sudo bash ./test.sh

test-repl: build
	sudo bash test-repl.sh

publish:
	docker push keyvanfatehi/strider-docker-slave

.PHONY: test-repl
