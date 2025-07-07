FROM node:18

# Dossier de travail
WORKDIR /app

# Copier les fichiers de dépendances
COPY package*.json ./

# Installer les dépendances (express, mysql2, bcrypt, etc.)
RUN npm install

# Copier le reste des fichiers du backend
COPY . .

# Exposer le port d'écoute
EXPOSE 3000

# Lancer le serveur
CMD ["node", "index.js"]
