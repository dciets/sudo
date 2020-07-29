# Configurer sudo
Il y a des variables d'environnement à configurer pour faire fonctionner sudo.

## 1. Créer env.sh
Les variables d'environnement sont passées à sudo avec le fichier `env.sh`.

> **Ces variables sont sensibles, donc il ne faut absolument pas les commit dans le repo.**
> **Gardez toujours env.sh dans le `.gitignore`!**

Le fichier `env.sh.example` est un template de fichier `env.sh`. Copiez le vers `env.sh`. Vous allez ensuite devoir remplir les valeurs.

## 2. SLACK_TOKEN
C'est le token Slack de l'intégration. Vous pouvez le trouver dans la page de configuration de l'application Lita dans les paramètres du Slack. Si vous n'arrivez pas à lire le token Slack, vous pouvez détruire la configuration de Lita actuelle et en créer une autre.

## 3. CSE_ID
C'est l'identifiant unique du Google Custom Search Engine utilisé pour les recherches d'images (`sudo image ...`). Il y en a un déjà créé sur le compte Google de la DCI. Vous pouvez le trouver [sur le site de CSE](https://cse.google.com/cse/all), il s'appelle Google Images. La valeur que vous devez mettre dans `CSE_ID` est le "Search engine ID".

### Création d'un nouveau CSE
Si jamais vous devez créer un nouveau CSE, voici comment faire:

1. [Créer un nouveau search engine](https://cse.google.com/cse/all)
2. Entrer une URL bidon comme `perdu.com`
3. Donner un nom au search engine et appuyer sur Create
4. Aller dans le panneau de configuration du search engine
5. Mettre "Image Search" à ON
6. Mettre "Search the entire web" à ON

## 4. GOOGLE_API_KEY
La dernière valeur à insérer est la clé d'API Google, utilisée pour Youtube et CSE. Le projet est déjà créé sur le compte Google de la DCI.

1. [Allez sur la console de développeurs Google](https://console.developers.google.com)
2. Assurez-vous d'être sur le projet sudo qui a une clé d'API Custom Search et Youtube Data API v3
3. Cliquez sur identifiants dans le menu à gauche et copiez la clé d'API dans le fichier `env.sh`

### Création d'un projet Google
Si jamais vous avez besoin de créer un nouveau projet Google pour sudo:

1. Créez un projet sur la console de développeurs Google
2. Ajoutez Youtube Data API v3 aux APIs du projet
3. Créez un identifiant pour l'API de YouTube pour obtenir une clé d'API
4. Ajoutez Custom Search API aux APIs du projet
5. Créez un compte pour Custom Search API. Vous pouvez donner le rôle Projet > Lecteur.
6. Cliquez sur identifiants dans le menu à gauche et copiez la clé d'API dans le fichier `env.sh`

# Rouler sudo avec Docker et Docker Compose
Une fois sudo configuré, vous pouvez simplement faire `compose up -d` à la racine du repo et ça devrait marcher!

# Rouler sudo au démarrage
Pour rouler sudo au démarrage, créez un service systemd en créant le fichier `/etc/systemd/system/sudo.service`:

```
[Unit]
Description=Docker Compose service for sudo bot
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=<sudo project directory>
ExecStart=/usr/local/bin/docker-compose up -d
ExecStop=/usr/local/bin/docker-compose down
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
```

Remplacez `<sudo project directory>` par le chemin du dossier de sudo.

Pour rouler le service au démarrage:
```
sudo systemctl enable sudo
```

Pour rouler le service sans redémarrer le serveur:
```
sudo systemctl start sudo
```
