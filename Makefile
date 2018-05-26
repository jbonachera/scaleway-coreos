build::
	docker build -t jbonachera/scaleway-coreos .

run:: build
	docker run -it \
  -v $$(pwd)/secrets.json:/srv/secrets.json \
  -v $$HOME/.scwrc:/root/.scwrc \
  scaleway-coreos
