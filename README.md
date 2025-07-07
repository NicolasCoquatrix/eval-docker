# Évaluation Docker

Ce projet déploie un site avec reverse proxy Nginx, un frontend et une API backend avec la possbilité de s'inscrire et de se connecter.

## Lancer le projet
```bash
docker compose --env-file .env up --build -d
```

## Lancer Adminer (Interface graphique pour la BDD)
```bash
docker compose --profile admin up -d
```