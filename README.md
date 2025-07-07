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


# 📦 `docker-compose.yml` – Résumé et explication

Ce fichier définit une architecture multi-conteneurs pour une application web complète avec interface, API, base de données, reverse proxy, interface de gestion et sauvegarde.

---

## 🔧 Services

| Service        | Rôle                                                           |
|----------------|----------------------------------------------------------------|
| `frontend`     | Interface web utilisateur                                      |
| `backend`      | API Node.js connectée à MySQL                                  |
| `db`           | Base de données MySQL                                          |
| `reverse-proxy`| NGINX servant de proxy pour le frontend et backend             |
| `adminer`      | Interface web pour gérer la base de données                    |
| `backup`       | Script de sauvegarde ponctuelle de la base de données          |

---

## 🌐 Réseaux

| Réseau         | Connecte les services                                           |
|----------------|-----------------------------------------------------------------|
| `frontend-net` | `frontend` ↔ `reverse-proxy`                                    |
| `backend-net`  | `backend` ↔ `reverse-proxy`                                     |
| `db-net`       | `backend`, `db`, `adminer`, `backup`                            |

---

## 📁 Volumes

| Volume         | Utilisation                                                    |
|----------------|----------------------------------------------------------------|
| `mysql-data`   | Stockage persistant des données MySQL                          |

---

## 🔄 Ordre de démarrage & dépendances
`db` démarre en premier
`backend` attend que db soit prêt (depends_on + healthcheck)
`frontend` est indépendant mais sert via le reverse proxy
`reverse-proxy` dépend de `frontend` et `backend`
`adminer` et `backup` sont optionnels, lancés via profils.
Tous sont reliés par des réseaux (`frontend-net`, `backend-net`, `db-net`) selon leur besoin.

---

## 📊 Schéma d’architecture

```text
                          ┌────────────────────────┐
                          │   Navigateur client    │
                          └────────────┬───────────┘
                                       │
                       http://localhost:${REVERSE_PROXY_PORT}
                                       │
                          ┌────────────▼────────────┐
                          │     reverse-proxy       │
                          │        (NGINX)          │
                          └───────┬────────┬────────┘
                                  │        │
             ┌────────────────────▼─┐   ┌──▼─────────────────────┐
             │     frontend         │   │      backend           │
             │ (interface web)      │   │    (API Node.js)       │
             └──────────────────────┘   └────┬──────────────┬────┘
                                             │              │
                                       ┌─────▼────┐   ┌─────▼──────┐
                                       │   db     │   │  adminer   │
                                       │ (MySQL)  │   │ (UI BDD)   │
                                       └────┬─────┘   └────────────┘
                                            │
                                     ┌──────▼───────┐
                                     │   backup     │
                                     │ (backup.sh)  │
                                     └──────────────┘
```

---

## 🧪 Lancement du projet

- Copier le fichier .env.template en .env et remplir les variables d'environnement (exeptionnelement, pour vous faciliter la tâche lors de la correction, je vous ai joint le .env)

- Lancement normal (frontend, backend, db, reverse proxy) :
  ```bash
  docker compose up -d
  ```

- Lancer avec Adminer :
  ```bash
  docker-compose --profile admin up -d
  ```

- Lancer uniquement le conteneur de backup :
  ```bash
  docker-compose --profile backup up
  ```
