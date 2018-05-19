# Scaleway CoreOS builder

Build a CoreOS image from scratch on Scaleway (https://www.scaleway.com/) using
packer.
I'm currently using my own packer builder
(https://github.com/jbonachera/packer-scaleway-plugin) to be able to use
START1-M servers on scaleway.

## Usage

```
cp secrets.example.json secrets.json
vim secrets.json
docker build -t scaleway-coreos-builder .
docker run -it -v $(pwd)/secrets.json:/srv/secrets.json scaleway-coreos-builder build -var-file=/srv/secrets.json packer.json
```
