KEY := $(shell cat ~/.ssh/id_ed25519_centos.pub)

build-image:
	docker build -t ssh_image_test --build-arg ssh_pub_key="$(KEY)" .

run-container:
	# docker run -p 22:22 -d --rm ssh_image_test
	docker run -d --rm ssh_image_test

ip-inspect:
	docker inspect -f "{{ .NetworkSettings.IPAddress }}" $$(docker ps | grep ssh_image_test | awk '{print $$NF}')
