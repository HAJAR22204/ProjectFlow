# ProjetFlow — Système de Gestion de Projets

> Application web fullstack de gestion de projets développée dans le cadre d'un projet académique supervisé par **Pr. Mohamed LACHGAR**.

---

## Table des matières

- [Présentation](#présentation)
- [Technologies utilisées](#technologies-utilisées)
- [Architecture du projet](#architecture-du-projet)
- [Fonctionnalités](#fonctionnalités)
- [Prérequis](#prérequis)
- [Installation et lancement](#installation-et-lancement)
- [Lancement avec Docker](#lancement-avec-docker)
- [Base de données](#base-de-données)
- [Comptes de test](#comptes-de-test)
- [Sécurité et rôles](#sécurité-et-rôles)
- [API REST — Documentation Swagger](#api-rest--documentation-swagger)
- [Structure du projet](#structure-du-projet)
- [Démonstration vidéo](#démonstration-vidéo)

---

## Présentation

**ProjetFlow** est une application fullstack de gestion de projets qui permet de suivre l'ensemble du cycle de vie d'un projet : de la création à la clôture, en passant par les phases, les affectations d'employés, les livrables, les documents et la facturation.

L'application propose :
- Un **backend REST** développé avec Spring Boot et sécurisé par JWT
- Un **frontend moderne** développé avec React, TypeScript et Tailwind CSS
- Une **interface responsive** avec tableau de bord, reporting et menus dynamiques selon le rôle
- Un **déploiement Docker** complet avec MySQL, backend et frontend conteneurisés

---

## Technologies utilisées

### Backend
| Technologie | Version | Rôle |
|-------------|---------|------|
| Java | 17 | Langage |
| Spring Boot | 3.x | Framework principal |
| Spring Security | 3.x | Sécurité et authentification |
| Spring Data JPA | 3.x | Accès base de données |
| JWT (JJWT) | — | Tokens d'authentification |
| MySQL | 8.0 | Base de données relationnelle |
| Lombok | — | Réduction du boilerplate |
| Swagger / OpenAPI | — | Documentation API |
| Maven | — | Gestion des dépendances |

### Frontend
| Technologie | Version | Rôle |
|-------------|---------|------|
| React | 19 | Framework UI |
| TypeScript | 5.x | Typage statique |
| Vite | 8.x | Build tool |
| Tailwind CSS | 3.x | Styling utilitaire |
| React Router DOM | 7.x | Navigation SPA |
| Axios | 1.x | Appels HTTP |
| React Hook Form | 7.x | Gestion des formulaires |
| Recharts | 3.x | Graphiques et dashboard |
| Framer Motion | 12.x | Animations |
| Lucide React | — | Icônes |

### DevOps
| Technologie | Rôle |
|-------------|------|
| Docker | Conteneurisation |
| Docker Compose | Orchestration multi-services |
| Nginx | Serveur frontend en production |
|  

---

## Architecture du projet


<img width="1200" height="900" alt="architecture_projectflow_clean" src="https://github.com/user-attachments/assets/a89c0c56-1efa-477b-b0c5-f8c777ac591b" />

### Le backend + docker files

<img width="807" height="902" alt="image" src="https://github.com/user-attachments/assets/7a28d3d6-6712-4449-9d9a-f98b9e261d05" />

### Le frontend

<img width="811" height="857" alt="image" src="https://github.com/user-attachments/assets/407fa163-d4dd-4392-9b8f-91069e748ab5" />


---

## Fonctionnalités

### Modules métier
| Module | Fonctionnalités |
|--------|----------------|
| **Organismes** | CRUD, recherche par nom / code / contact |
| **Employés** | CRUD, recherche multicritère, disponibilité par période |
| **Projets** | CRUD, lien organisme + chef de projet, contrôle des dates |
| **Phases** | CRUD, états réalisation / facturation / paiement, contrôle montants |
| **Affectations** | Clé composée employé-phase, contrôle disponibilité, historique |
| **Livrables** | Gestion par phase, statut de validation |
| **Documents** | Métadonnées, upload, téléchargement sécurisé |
| **Factures** | Création depuis une phase terminée, états (Émise / Payée / En attente) |
| **Reporting** | Tableau de bord, phases non facturées, factures non payées, graphiques |

### Sécurité
- Authentification JWT (login → token → accès protégé)
- BCrypt pour le hashage des mots de passe
- Routes React protégées par `PrivateRoute`
- Menu dynamique selon le rôle de l'utilisateur connecté
- Restrictions des endpoints Spring Security par rôle

---

## Prérequis

- **Java 17+**
- **Maven 3.8+**
- **Node.js 18+** et **npm**
- **MySQL 8.0+**
- **Docker & Docker Compose** *(optionnel)*

---

## Installation et lancement

### 1. Cloner le projet

```bash
git clone https://github.com/VOTRE_USERNAME/projetflow.git
cd projetflow
```

### 2. Configurer la base de données

Modifier `src/main/resources/application.properties` si nécessaire :

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/gestion_projets?createDatabaseIfNotExist=true
spring.datasource.username=root
spring.datasource.password=       # votre mot de passe MySQL
server.port=8081
```

### 3. Lancer le backend

```bash
# Depuis la racine du projet
mvn spring-boot:run
```

> Au premier démarrage, Spring Boot crée automatiquement toutes les tables et insère le compte administrateur.

Le backend est accessible sur : `http://localhost:8081`

### 4. Lancer le frontend

```bash
cd gestion-projets-frontend
npm install
npm run dev
```

Le frontend est accessible sur : `http://localhost:5173`

---

## Lancement avec Docker

Le projet inclut un `docker-compose.yml` qui orchestre **3 services** : MySQL, le backend Spring Boot et le frontend Nginx.

```bash
# Construire et démarrer tous les services
docker-compose up --build

# En arrière-plan
docker-compose up --build -d

# Arrêter les services
docker-compose down
```

| Service | Port exposé | Description |
|---------|------------|-------------|
| `db` | 3306 | MySQL 8.0 |
| `backend` | 8081 | API Spring Boot |
| `frontend` | 3000 | React servi par Nginx |

> Le frontend Docker est accessible sur `http://localhost:3000`

Le service `backend` attend que MySQL soit sain (healthcheck) avant de démarrer.

---

## Base de données

### Initialisation automatique

Au premier démarrage du backend, le `DataInitializer` crée automatiquement :
- Tous les profils (ADMINISTRATEUR, DIRECTEUR, CHEF_PROJET, COMPTABLE, SECRETAIRE, INGENIEUR, TECHNICIEN, EMPLOYE)
- Le compte administrateur par défaut

### Les tableaux cree dans la base

Si vous lancez l'application depuis votre IDE (IntelliJ, Eclipse) :

<img width="1170" height="539" alt="image" src="https://github.com/user-attachments/assets/249d0469-a7d6-47d7-b8a2-36a4b650c377" />


### Schéma 

<img width="1407" height="862" alt="image" src="https://github.com/user-attachments/assets/c2977df4-c4fb-4bc4-8427-f0a3be0ce0b4" />

---

## Comptes de test

| Login | Mot de passe | Rôle |
|-------|-------------|------|
| `admin` | `admin123` | Administrateur — accès complet |
| `melfassi` | `admin123` | Directeur |
| `sbenhaddou` | `admin123` | Secrétaire |
| `rouali` | `admin123` | Chef de Projet |
| `lamrani` | `admin123` | Chef de Projet |
| `hcherkaoui` | `admin123` | Comptable |
| `ibenali` | `admin123` | Ingénieur |
| `ytahiri` | `admin123` | Ingénieur |
| `amoukhliss` | `admin123` | Technicien |
| `kziani` | `admin123` | Employé |

---

## Sécurité et rôles

L'accès aux modules est restreint selon le profil de l'utilisateur connecté. Le menu latéral s'adapte dynamiquement au rôle.

| Module | ADMIN | DIRECTEUR | CHEF_PROJET | COMPTABLE | SECRETAIRE | EMPLOYE |
|--------|:-----:|:---------:|:-----------:|:---------:|:----------:|:-------:|
| Tableau de bord | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Organismes | ✅ | ✅ | — | — | ✅ | — |
| Employés | ✅ | — | — | — | — | — |
| Profils | ✅ | — | — | — | — | — |
| Projets | ✅ | — | — | — | — | — |
| Phases | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Affectations | ✅ | ✅ | ✅ | — | — | ✅ |
| Livrables | ✅ | ✅ | ✅ | — | — | ✅ |
| Documents | ✅ | ✅ | ✅ | — | ✅ | ✅ |
| Factures | ✅ | ✅ | — | ✅ | — | — |
| Reporting | ✅ | ✅ | — | ✅ | — | — |

---

## API REST — Documentation Swagger

La documentation interactive de l'API est disponible après démarrage du backend :
Après avoir démarré le backend, vous pouvez consulter et interagir avec la documentation complète à l'adresse suivante :

👉 http://localhost:8081/swagger-ui/index.html
```
http://localhost:8081/swagger-ui.html
```

### Principaux endpoints

```
# Authentification
POST   /api/auth/login
GET    /api/auth/me
POST   /api/auth/change-password

# Organismes
GET    /api/organismes
POST   /api/organismes
PUT    /api/organismes/{id}
DELETE /api/organismes/{id}

# Employés
GET    /api/employes
POST   /api/employes
GET    /api/employes/disponibles?dateDebut=...&dateFin=...

# Projets
GET    /api/projets
POST   /api/projets
GET    /api/projets/{id}/resume

# Phases
GET    /api/projets/{projetId}/phases
POST   /api/projets/{projetId}/phases
PATCH  /api/phases/{id}/realisation
PATCH  /api/phases/{id}/facturation
PATCH  /api/phases/{id}/paiement

# Affectations
POST   /api/phases/{phaseId}/employes/{employeId}
GET    /api/employes/{employeId}/phases

# Livrables
GET    /api/phases/{phaseId}/livrables
POST   /api/phases/{phaseId}/livrables

# Factures
POST   /api/phases/{phaseId}/facture
GET    /api/factures

# Reporting
GET    /api/reporting/tableau-de-bord
GET    /api/reporting/phases/terminees-non-facturees
GET    /api/reporting/phases/facturees-non-payees
GET    /api/reporting/projets/en-cours
GET    /api/reporting/projets/clotures
```
![WhatsApp Image 2026-04-10 at 5 42 57 PM](https://github.com/user-attachments/assets/8dbc0278-374e-4ffb-ab27-2df2dd493d73)
![WhatsApp Image 2026-04-10 at 5 48 58 PM](https://github.com/user-attachments/assets/ad0a29b1-a310-4439-8eae-a833e162811d)

---

## Structure du projet

Le projet suit le plan de travail académique en **14 phases** :

| Phase | Description | Statut |
|-------|-------------|--------|
| 1 | Initialisation Spring Boot, configuration DB, architecture packages | ✅ |
| 2 | Modélisation entités JPA (Profil, Employe, Organisme, Projet, Phase…) | ✅ |
| 3 | Repositories et requêtes métier | ✅ |
| 4 | Module Organismes (CRUD + recherche) | ✅ |
| 5 | Module Employés (CRUD + disponibilité) | ✅ |
| 6 | Module Projets (CRUD + règles métier) | ✅ |
| 7 | Module Phases (états réalisation / facturation / paiement) | ✅ |
| 8 | Module Affectations (clé composée employé-phase) | ✅ |
| 9 | Module Livrables | ✅ |
| 10 | Module Documents projet | ✅ |
| 11 | Module Factures | ✅ |
| 12 | Reporting et tableau de bord | ✅ |
| 13 | Validation, exceptions personnalisées, Swagger | ✅ |
| 14 | Spring Security + JWT + rôles + routes protégées | ✅ |

---

## Démonstration vidéo






https://github.com/user-attachments/assets/73a4496a-04b2-4686-9914-d61b81b62815





La démonstration couvrira :
- Connexion avec différents rôles et navigation selon les droits
- Création d'un organisme, d'un projet et de ses phases
- Affectation d'employés et suivi des livrables
- Gestion de la facturation et consultation du reporting
---


*ProjetFlow — Gestion de Projets Fullstack — Spring Boot + React + Docker*
