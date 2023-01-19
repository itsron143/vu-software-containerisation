# Software Containerisation

Project space for Software Containerisation, VU Amsterdam.

# Docker Instructions

Add a `.env` file at the root of the project. The file format is like this:

```
POSTGRES_USER=<FILL_UP>
POSTGRES_PASSWORD=<FILL_UP>
POSTGRES_DB=<FILL_UP>
```

> make sure you have docker installed.

```bash
docker-compose up -d
```

Check if docker containers are running:

```bash
docker ps
```

The web app should be avaialble at `localhost:5001`
