# Goal
Create a Docker file that creates an image that can be used for Phnx development.

# Buil

```
docker build -t dev_env .
```

# Run

```
docker run -ti  --mount \
type=bind,source=/Users/smounitz/fm-repos/oms, target=/home/fmpub/FM  \
--rm --name phnx -p 8181:80 dev_env
```