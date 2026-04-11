-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : sam. 11 avr. 2026 à 15:09
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `gestion_projets`
--

-- --------------------------------------------------------

--
-- Structure de la table `affectations`
--

CREATE TABLE `affectations` (
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `description` text DEFAULT NULL,
  `role` varchar(100) DEFAULT NULL,
  `statut` varchar(50) DEFAULT NULL,
  `employe_id` bigint(20) NOT NULL,
  `phase_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `affectations`
--

INSERT INTO `affectations` (`date_debut`, `date_fin`, `description`, `role`, `statut`, `employe_id`, `phase_id`) VALUES
('2024-01-15', '2024-02-28', 'Rédaction du cahier des charges', 'Analyste fonctionnel', 'TERMINE', 9, 1),
('2024-05-01', '2024-07-31', 'Développement des APIs REST Spring Boot', 'Développeur Backend', 'EN_COURS', 9, 3),
('2024-07-01', '2024-10-31', 'Développement module dossiers médicaux', 'Développeur Senior', 'EN_COURS', 9, 8),
('2024-05-01', '2024-07-31', 'Intégration base de données et sécurité', 'Développeur Backend', 'EN_COURS', 10, 3),
('2024-03-01', '2024-04-15', 'Coordination de l\'étude de faisabilité', 'Chef de projet adjoint', 'TERMINE', 10, 6),
('2024-07-01', '2024-09-30', 'Supervision du déploiement Casablanca', 'Ingénieur Réseau', 'EN_COURS', 10, 16),
('2024-01-15', '2024-02-28', 'Analyse de l\'infrastructure existante', 'Analyste technique', 'TERMINE', 11, 1),
('2024-06-01', '2024-08-31', 'Développement React et intégration APIs', 'Développeur Frontend', 'EN_COURS', 11, 4),
('2024-07-01', '2024-10-31', 'Tests et sécurisation des données', 'Développeur', 'EN_COURS', 11, 8),
('2024-03-01', '2024-04-15', 'Analyse des besoins médicaux', 'Analyste', 'TERMINE', 12, 6),
('2024-07-01', '2024-09-30', 'Installation équipements actifs', 'Technicien Réseau', 'EN_COURS', 12, 16),
('2024-06-01', '2024-08-31', 'Intégration et tests UI', 'Intégrateur', 'EN_COURS', 13, 4),
('2024-09-01', '2024-12-31', 'Déploiement axe Rabat-Salé', 'Technicien', 'EN_COURS', 13, 17),
('2024-03-01', '2024-04-30', NULL, 'developpeur', NULL, 15, 2);

-- --------------------------------------------------------

--
-- Structure de la table `commentaires`
--

CREATE TABLE `commentaires` (
  `id` bigint(20) NOT NULL,
  `contenu` text NOT NULL,
  `date_creation` datetime(6) DEFAULT NULL,
  `auteur_id` bigint(20) DEFAULT NULL,
  `phase_id` bigint(20) DEFAULT NULL,
  `projet_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `commentaires`
--

INSERT INTO `commentaires` (`id`, `contenu`, `date_creation`, `auteur_id`, `phase_id`, `projet_id`) VALUES
(1, 'Le cahier des charges a été validé par le client ONE. Nous pouvons passer à la phase de conception.', '2024-02-28 10:30:00.000000', 6, NULL, 1),
(2, 'Retard de 2 semaines sur le développement backend dû à des changements de spécifications de dernière minute. Planning mis à jour.', '2024-06-15 14:00:00.000000', 6, 3, NULL),
(3, 'Réunion de suivi avec le Ministère de la Santé : très satisfaits des maquettes présentées. Quelques ajustements mineurs demandés.', '2024-06-28 16:00:00.000000', 7, NULL, 2),
(4, 'Module dossiers médicaux : avancement à 55%. Les APIs de chiffrement des données sont terminées. Démarrage de l\'interface la semaine prochaine.', '2024-09-20 09:00:00.000000', 9, 8, NULL),
(5, 'Projet SI Communal Fès clôturé avec succès ! PV de recette signé. Le client est très satisfait du résultat.', '2024-05-31 17:30:00.000000', 6, NULL, 3),
(6, 'Déploiement Casablanca à 90%. Les derniers tronçons seront finalisés cette semaine avant la livraison officielle.', '2024-09-25 11:00:00.000000', 10, 16, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `documents_projet`
--

CREATE TABLE `documents_projet` (
  `id` bigint(20) NOT NULL,
  `chemin` varchar(500) DEFAULT NULL,
  `code` varchar(50) NOT NULL,
  `date_ajout` datetime(6) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `libelle` varchar(200) NOT NULL,
  `type_document` varchar(100) DEFAULT NULL,
  `projet_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `documents_projet`
--

INSERT INTO `documents_projet` (`id`, `chemin`, `code`, `date_ajout`, `description`, `libelle`, `type_document`, `projet_id`) VALUES
(1, NULL, 'DOC001', '2024-01-10 09:00:00.000000', 'Contrat signé pour le projet Système Abonnés ONE.', 'Contrat de Prestation ONE', 'Contrat', 1),
(2, NULL, 'DOC002', '2024-01-15 14:00:00.000000', 'Procès-verbal de la réunion de lancement avec le client ONE.', 'PV Réunion Lancement PRJ001', 'PV Réunion', 1),
(3, NULL, 'DOC003', '2024-01-20 10:00:00.000000', 'Planning détaillé, ressources et jalons du projet.', 'Plan de Projet ONE', 'Plan projet', 1),
(4, NULL, 'DOC004', '2024-02-25 09:00:00.000000', 'Contrat de prestation pour la plateforme e-santé.', 'Contrat E-Santé Nationale', 'Contrat', 2),
(5, NULL, 'DOC005', '2024-03-01 11:00:00.000000', 'Document de cadrage et périmètre du projet e-santé.', 'Note de Cadrage E-Santé', 'Cadrage', 2),
(6, NULL, 'DOC006', '2024-05-31 17:00:00.000000', 'Rapport de clôture complet du projet SI Communal.', 'Rapport Final SI Communal Fès', 'Rapport', 3),
(7, NULL, 'DOC007', '2024-05-31 16:00:00.000000', 'Procès-verbal de recette et acceptance finale signés.', 'PV Recette Finale Fès', 'PV Recette', 3),
(8, NULL, 'DOC008', '2024-04-28 09:00:00.000000', 'Contrat de déploiement réseau fibre pour Maroc Telecom.', 'Contrat Infrastructure IAM', 'Contrat', 4),
(9, NULL, 'DOC009', '2024-05-01 10:00:00.000000', 'Spécifications techniques du déploiement réseau.', 'Cahier des Clauses Techniques IAM', 'Technique', 4),
(10, NULL, 'DOC010', '2024-08-30 17:00:00.000000', 'Rapport final de clôture du module RH OCP.', 'Rapport de Clôture OCP RH', 'Rapport', 5);

-- --------------------------------------------------------

--
-- Structure de la table `employe`
--

CREATE TABLE `employe` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `prenom` varchar(255) DEFAULT NULL,
  `telephone` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `employe`
--

INSERT INTO `employe` (`id`, `nom`, `prenom`, `telephone`) VALUES
(1, 'Alami', 'Sami', '0612345678');

-- --------------------------------------------------------

--
-- Structure de la table `employes`
--

CREATE TABLE `employes` (
  `id` bigint(20) NOT NULL,
  `actif` bit(1) NOT NULL,
  `adresse` varchar(200) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `login` varchar(100) NOT NULL,
  `matricule` varchar(50) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `profil_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `employes`
--

INSERT INTO `employes` (`id`, `actif`, `adresse`, `email`, `login`, `matricule`, `nom`, `password`, `prenom`, `telephone`, `profil_id`) VALUES
(1, b'1', NULL, 'admin@gestionprojets.ma', 'admin', 'ADM001', 'Admin', '$2a$10$Y0nuCSDbyuqRNTT/MiTgWusQBaj7AZ4klzNr49Vg14KZh2MSyqWsi', 'Système', NULL, 1),
(4, b'1', NULL, 'm.elfassi@projetflow.ma', 'melfassi', 'DIR001', 'El Fassi', '$2a$10$c1XAr1XjFVTqX05y1PhdF.Ae2IAhMI2AfAs4FjXBD2Kc89ACI/WbG', 'Mohammed', '0661234501', 2),
(5, b'1', NULL, 's.benhaddou@projetflow.ma', 'sbenhaddou', 'SEC001', 'Benhaddou', '$2a$10$1CU1qBWmMWvgkbt393Cu4Od0eLuspNck4JWuSjyqY5Ws0RVqw1A9G', 'Sanae', '0661234502', 3),
(6, b'1', NULL, 'r.ouali@projetflow.ma', 'rouali', 'CP001', 'Ouali', '$2a$10$TtVJmE1LvedwR5TsHzEFG.F4LdsnYvX7WgDXQSvhPMV/afJB7yLdC', 'Rachid', '0661234503', 4),
(7, b'1', 'Marrakech', 'l.amrani@projetflow.ma', 'lamrani', 'CP002', 'Amrani', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'Leila', '0661234504', 4),
(8, b'1', NULL, 'h.cherkaoui@projetflow.ma', 'hcherkaoui', 'COM001', 'Cherkaoui', '$2a$10$NeeZNQODHQ5IYAp13cIi/.z2JPogil7sBXv/H7X.n49Ah8pJM6fMK', 'Hassan', '0661234505', 5),
(9, b'1', 'Casablanca', 'i.benali@projetflow.ma', 'ibenali', 'ING001', 'Benali', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'Imane', '0661234506', 7),
(10, b'1', NULL, 'y.tahiri@projetflow.ma', 'tahiri', 'ING002', 'Tahiri', '$2a$10$OXGJs6JhLMSF.wPMXUsnD.QzoGSOT5EKLTz4rNENNOxL9rZ.c5BLS', 'Yassine', '0661234507', 7),
(11, b'1', 'Tanger', 'a.moukhliss@projetflow.ma', 'amoukhliss', 'TEC001', 'Moukhliss', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'Amine', '0661234508', 6),
(12, b'1', NULL, 'd.sabri@projetflow.ma', 'dsabri', 'TEC002', 'Sabri', '$2a$10$uCfRRbLOEcBHzT/dx9sCfOlLw6ybFtegF5mW0siZ.gjt.hYlQE8xW', 'Dounia', '0661234509', 6),
(13, b'1', NULL, 'k.ziani@projetflow.ma', 'kziani', 'EMP001', 'Ziani', '$2a$10$pYDcYwReWseckQX6nLfjIuLvpbeFamWJZIghhGM3nWgTh663YhRti', 'Khalid', '0661234510', 8),
(15, b'1', NULL, 'test@test.com', 'hajar', 'EMP002', 'zegour', '$2a$10$nAKLcopFocIbL3nwmfe1zuMOajVMDf9Gfvu0/iFgd7QwrrjnhskVS', 'hajar', '0600000000', 8);

-- --------------------------------------------------------

--
-- Structure de la table `employetache`
--

CREATE TABLE `employetache` (
  `employe_id` int(11) NOT NULL,
  `tache_id` int(11) NOT NULL,
  `dateDebutReelle` date DEFAULT NULL,
  `dateFinReelle` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `employetache`
--

INSERT INTO `employetache` (`employe_id`, `tache_id`, `dateDebutReelle`, `dateFinReelle`) VALUES
(1, 1, '2013-02-10', '2013-02-20'),
(1, 2, '2013-03-10', '2013-03-15'),
(1, 3, '2013-04-10', '2013-04-25');

-- --------------------------------------------------------

--
-- Structure de la table `factures`
--

CREATE TABLE `factures` (
  `id` bigint(20) NOT NULL,
  `code` varchar(50) NOT NULL,
  `date_facture` date NOT NULL,
  `date_paiement` date DEFAULT NULL,
  `montant` double DEFAULT NULL,
  `reference` varchar(50) DEFAULT NULL,
  `statut` enum('ANNULEE','EMISE','EN_ATTENTE','PAYEE') DEFAULT NULL,
  `phase_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `factures`
--

INSERT INTO `factures` (`id`, `code`, `date_facture`, `date_paiement`, `montant`, `reference`, `statut`, `phase_id`) VALUES
(1, 'FAC-2024-001', '2024-03-01', '2024-03-20', 120000, 'BC-ONE-2024-001', 'PAYEE', 1),
(2, 'FAC-2024-002', '2024-05-05', '2024-05-25', 150000, 'BC-ONE-2024-002', 'PAYEE', 2),
(3, 'FAC-2024-003', '2024-04-20', '2024-05-15', 200000, 'BC-SANTE-001', 'PAYEE', 6),
(4, 'FAC-2024-004', '2024-07-05', NULL, 280000, 'BC-SANTE-002', 'EMISE', 7),
(5, 'FAC-2023-001', '2023-08-05', '2023-08-25', 180000, 'BC-FES-2023-001', 'PAYEE', 11),
(6, 'FAC-2023-002', '2023-11-05', '2023-11-30', 380000, 'BC-FES-2023-002', 'PAYEE', 12),
(7, 'FAC-2024-005', '2024-03-05', '2024-04-01', 420000, 'BC-FES-2024-001', 'PAYEE', 13),
(8, 'FAC-2024-006', '2024-06-05', '2024-06-28', 220000, 'BC-FES-2024-002', 'PAYEE', 14),
(9, 'FAC-2024-007', '2024-07-10', '2024-08-01', 350000, 'BC-IAM-2024-001', 'PAYEE', 15),
(10, 'FAC-2024-008', '2024-10-10', NULL, 720000, 'BC-IAM-2024-002', 'EN_ATTENTE', 16),
(11, 'FAC-2023-003', '2023-10-20', '2023-11-10', 120000, 'BC-OCP-2023-001', 'PAYEE', 20),
(12, 'FAC-2024-009', '2024-02-10', '2024-03-05', 280000, 'BC-OCP-2024-001', 'PAYEE', 21),
(13, 'FAC-2024-010', '2024-06-10', '2024-07-01', 330000, 'BC-OCP-2024-002', 'PAYEE', 22),
(14, 'FAC-2024-011', '2024-09-05', '2024-09-25', 250000, 'BC-OCP-2024-003', 'PAYEE', 23);

-- --------------------------------------------------------

--
-- Structure de la table `livrables`
--

CREATE TABLE `livrables` (
  `id` bigint(20) NOT NULL,
  `chemin` varchar(500) DEFAULT NULL,
  `code` varchar(50) NOT NULL,
  `date_remise` date DEFAULT NULL,
  `description` text DEFAULT NULL,
  `libelle` varchar(200) NOT NULL,
  `type_fichier` varchar(100) DEFAULT NULL,
  `valide` bit(1) DEFAULT NULL,
  `phase_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `livrables`
--

INSERT INTO `livrables` (`id`, `chemin`, `code`, `date_remise`, `description`, `libelle`, `type_fichier`, `valide`, `phase_id`) VALUES
(1, NULL, 'LIV001', '2024-02-20', 'Document complet des spécifications fonctionnelles du système abonnés.', 'Cahier des Charges Fonctionnel', 'PDF', b'1', 1),
(2, NULL, 'LIV002', '2024-02-25', 'Rapport d\'analyse de l\'infrastructure existante et des processus actuels.', 'Rapport d\'Audit Existant', 'PDF', b'1', 1),
(3, NULL, 'LIV003', '2024-04-25', 'Schéma d\'architecture, choix technologiques et modèle de données.', 'Dossier d\'Architecture Technique', 'PDF', b'1', 2),
(4, NULL, 'LIV004', '2024-04-28', 'Prototypes interactifs validés des interfaces utilisateur.', 'Maquettes UI/UX', 'FIGMA', b'1', 2),
(5, NULL, 'LIV005', '2024-07-15', 'Code source Spring Boot avec APIs REST documentées sur Swagger.', 'Code Source Backend v1', 'ZIP', b'0', 3),
(6, NULL, 'LIV006', '2024-07-20', 'Documentation Swagger/OpenAPI de toutes les APIs développées.', 'Documentation API', 'PDF', b'0', 3),
(7, NULL, 'LIV007', '2024-04-10', 'Étude de faisabilité technique et financière de la plateforme e-santé.', 'Rapport de Faisabilité E-Santé', 'PDF', b'1', 6),
(8, NULL, 'LIV008', '2024-06-25', 'Prototypes interactifs des interfaces validés par les équipes médicales.', 'Prototypes UX Validés', 'FIGMA', b'1', 7),
(9, NULL, 'LIV009', '2024-09-30', 'Version intermédiaire du module avec fonctionnalités de base.', 'Module Dossiers Médicaux v0.5', 'ZIP', b'0', 8),
(10, NULL, 'LIV010', '2023-07-28', 'Audit complet du SI existant avec recommandations.', 'Rapport d\'Audit SI Communal', 'PDF', b'1', 11),
(11, NULL, 'LIV011', '2023-10-28', 'Application de gestion de l\'état civil déployée en production.', 'Application État Civil v1.0', 'ZIP', b'1', 12),
(12, NULL, 'LIV012', '2024-02-25', 'Portail citoyen en ligne déployé et testé.', 'Portail Citoyen v1.0', 'ZIP', b'1', 13),
(13, NULL, 'LIV013', '2024-05-28', 'Documentation utilisateur complète et procès-verbal de recette signé.', 'Manuel Utilisateur & PV Recette', 'PDF', b'1', 14),
(14, NULL, 'LIV014', '2024-06-28', 'Plan détaillé de déploiement avec cartographie des 5 villes.', 'Plan de Déploiement Réseau', 'PDF', b'1', 15),
(15, NULL, 'LIV015', '2024-09-25', 'Rapport d\'avancement du déploiement axe Casablanca à 90%.', 'Rapport Déploiement Casablanca', 'PDF', b'0', 16);

-- --------------------------------------------------------

--
-- Structure de la table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) NOT NULL,
  `date_creation` datetime(6) DEFAULT NULL,
  `lue` bit(1) DEFAULT NULL,
  `message` varchar(200) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `employe_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `notifications`
--

INSERT INTO `notifications` (`id`, `date_creation`, `lue`, `message`, `type`, `employe_id`) VALUES
(1, '2024-07-25 08:00:00.000000', b'0', 'La phase PH001-3 Développement Backend arrive à échéance le 31/07/2024.', 'ALERTE', 6),
(2, '2024-07-01 09:00:00.000000', b'1', 'Nouvelle affectation : vous êtes affecté à la phase Déploiement Casablanca.', 'INFO', 10),
(3, '2024-08-05 08:00:00.000000', b'0', 'La facture FAC-2024-004 est en attente de paiement depuis plus de 30 jours.', 'ALERTE', 8),
(4, '2024-09-15 10:00:00.000000', b'0', 'Le projet E-Santé Nationale vient d\'atteindre 50% d\'avancement global.', 'INFO', 4),
(5, '2024-07-15 14:00:00.000000', b'0', 'Livrable LIV005 soumis et en attente de validation.', 'INFO', 6),
(6, '2024-05-31 18:00:00.000000', b'1', 'Félicitations ! Le projet SI Communal de Fès a été clôturé avec succès.', 'SUCCES', 4);

-- --------------------------------------------------------

--
-- Structure de la table `organismes`
--

CREATE TABLE `organismes` (
  `id` bigint(20) NOT NULL,
  `adresse` varchar(300) DEFAULT NULL,
  `code` varchar(50) NOT NULL,
  `email_contact` varchar(150) DEFAULT NULL,
  `nom` varchar(200) NOT NULL,
  `nom_contact` varchar(150) DEFAULT NULL,
  `pays` varchar(50) DEFAULT NULL,
  `secteur_activite` varchar(100) DEFAULT NULL,
  `site_web` varchar(200) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `organismes`
--

INSERT INTO `organismes` (`id`, `adresse`, `code`, `email_contact`, `nom`, `nom_contact`, `pays`, `secteur_activite`, `site_web`, `telephone`) VALUES
(1, 'Bd Mohammed V, Casablanca', 'ORG001', 'a.bennani@one.ma', 'Office National de l\'Électricité', 'Ahmed Bennani', 'Maroc', 'Énergie', 'www.one.ma', '0522201010'),
(2, 'Rue Lamfadal, Rabat', 'ORG002', 'f.elidrissi@sante.gov.ma', 'Ministère de la Santé', 'Fatima Zohra El Idrissi', 'Maroc', 'Santé publique', 'www.sante.gov.ma', '0537687000'),
(3, 'Place Mohammed V, Fès', 'ORG003', 'k.alami@commune-fes.ma', 'Commune Urbaine de Fès', 'Karim Alami', 'Maroc', 'Administration publique', 'www.commune-fes.ma', '0535621100'),
(4, 'Avenue Annakhil, Rabat', 'ORG004', 'y.tazi@iam.ma', 'Maroc Telecom', 'Youssef Tazi', 'Maroc', 'Télécommunications', 'www.iam.ma', '0537718400'),
(5, 'Bd Hassan II, Casablanca', 'ORG005', 'n.benkirane@ocpgroup.ma', 'OCP Group', 'Nadia Benkirane', 'Maroc', 'Industrie minière', 'www.ocpgroup.ma', '0522232300');

-- --------------------------------------------------------

--
-- Structure de la table `phases`
--

CREATE TABLE `phases` (
  `id` bigint(20) NOT NULL,
  `code` varchar(50) NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `description` text DEFAULT NULL,
  `etat_facturation` bit(1) NOT NULL,
  `etat_paiement` bit(1) NOT NULL,
  `etat_realisation` bit(1) NOT NULL,
  `libelle` varchar(200) NOT NULL,
  `montant` double NOT NULL,
  `pourcentage` int(11) DEFAULT NULL,
  `projet_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `phases`
--

INSERT INTO `phases` (`id`, `code`, `date_debut`, `date_fin`, `description`, `etat_facturation`, `etat_paiement`, `etat_realisation`, `libelle`, `montant`, `pourcentage`, `projet_id`) VALUES
(1, 'PH001-1', '2024-01-15', '2024-02-28', 'Recueil des besoins, analyse fonctionnelle et rédaction du cahier des charges détaillé.', b'1', b'1', b'1', 'Analyse & Spécifications', 120000, 100, 1),
(2, 'PH001-2', '2024-03-01', '2024-04-30', 'Conception de l\'architecture technique, modélisation de la base de données et maquettage UI.', b'1', b'1', b'1', 'Conception & Architecture', 150000, 100, 1),
(3, 'PH001-3', '2024-05-01', '2024-07-31', 'Développement des APIs REST, logique métier, sécurité JWT et intégration base de données.', b'0', b'0', b'0', 'Développement Backend', 250000, 80, 1),
(4, 'PH001-4', '2024-06-01', '2024-08-31', 'Développement de l\'interface utilisateur responsive avec React et intégration des APIs.', b'1', b'1', b'1', 'Développement Frontend', 200000, 60, 1),
(5, 'PH001-5', '2024-09-01', '2024-12-31', 'Tests unitaires, intégration, recette utilisateur et déploiement en production.', b'0', b'0', b'0', 'Tests & Déploiement', 130000, 0, 1),
(6, 'PH002-1', '2024-03-01', '2024-04-15', 'Analyse de l\'existant, étude de faisabilité technique et financière, validation du périmètre.', b'1', b'1', b'1', 'Cadrage & Étude de faisabilité', 200000, 100, 2),
(7, 'PH002-2', '2024-04-16', '2024-06-30', 'Design des parcours utilisateurs, prototypage interactif et validation avec les équipes médicales.', b'1', b'0', b'1', 'Design UX/UI', 280000, 100, 2),
(8, 'PH002-3', '2024-07-01', '2024-10-31', 'Développement du module dossiers médicaux électroniques avec chiffrement des données.', b'0', b'0', b'0', 'Développement Module Dossiers', 650000, 55, 2),
(9, 'PH002-4', '2024-10-01', '2025-02-28', 'Développement de la plateforme de téléconsultation vidéo et messagerie sécurisée médecin-patient.', b'0', b'0', b'0', 'Module Téléconsultation', 780000, 20, 2),
(10, 'PH002-5', '2025-03-01', '2025-06-30', 'Intégration avec les SI hospitaliers existants, formation des équipes et mise een production.', b'0', b'0', b'0', 'Intégration & Formation', 490000, 0, 2),
(11, 'PH003-1', '2023-06-01', '2023-07-31', 'Audit complet du système d\'information actuel et identification des axes d\'amélioration.', b'1', b'1', b'1', 'Audit du SI existant', 180000, 100, 3),
(12, 'PH003-2', '2023-08-01', '2023-10-31', 'Numérisation des services d\'état civil : naissances, mariages, décès et extraits.', b'1', b'1', b'1', 'Développement État Civil', 380000, 100, 3),
(13, 'PH003-3', '2023-11-01', '2024-02-28', 'Développement du portail citoyen en ligne pour les démarches administratives à distance.', b'1', b'1', b'1', 'Portail Citoyen', 420000, 100, 3),
(14, 'PH003-4', '2024-03-01', '2024-05-31', 'Formation des agents communaux, documentation et remise du projet au client.', b'1', b'1', b'1', 'Formation & Clôture', 220000, 100, 3),
(15, 'PH004-1', '2024-05-01', '2024-06-30', 'Prospection terrain, cartographie des zones de déploiement et planification logistique.', b'1', b'1', b'1', 'Étude Terrain & Planification', 350000, 100, 4),
(16, 'PH004-2', '2024-07-01', '2024-09-30', 'Installation de la fibre optique et équipements actifs sur l\'axe Casablanca.', b'0', b'0', b'0', 'Déploiement Casablanca', 720000, 90, 4),
(17, 'PH004-3', '2024-09-01', '2024-12-31', 'Installation de la fibre optique sur l\'axe Rabat-Salé-Témara.', b'0', b'0', b'1', 'Déploiement Rabat & Salé', 680000, 40, 4),
(18, 'PH004-4', '2025-01-01', '2025-03-31', 'Installation sur les axes Fès, Tanger et Marrakech.', b'0', b'0', b'0', 'Déploiement Autres Villes', 1050000, 0, 4),
(19, 'PH004-5', '2025-02-01', '2025-03-31', 'Tests de performance réseau, optimisation et recette finale avec le client.', b'0', b'0', b'0', 'Tests & Recette', 300000, 0, 4),
(20, 'PH005-1', '2023-09-01', '2023-10-15', 'Analyse des processus RH existants et définition du périmètre fonctionnel du module.', b'1', b'1', b'1', 'Analyse RH', 120000, 100, 5),
(21, 'PH005-2', '2023-10-16', '2024-01-31', 'Développement du module de gestion de la paie automatisée avec règles de calcul spécifiques OCP.', b'1', b'1', b'1', 'Module Paie', 280000, 100, 5),
(22, 'PH005-3', '2024-02-01', '2024-05-31', 'Développement des modules gestion des congés, évaluations de performance et formation.', b'1', b'1', b'1', 'Module Congés & Eval', 330000, 100, 5),
(23, 'PH005-4', '2024-06-01', '2024-08-31', 'Tests de recette, correction des anomalies, formation utilisateurs et mise en production.', b'1', b'1', b'1', 'Recette & Déploiement', 250000, 100, 5);

-- --------------------------------------------------------

--
-- Structure de la table `profils`
--

CREATE TABLE `profils` (
  `id` bigint(20) NOT NULL,
  `code` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `libelle` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `profils`
--

INSERT INTO `profils` (`id`, `code`, `description`, `libelle`) VALUES
(1, 'ADMINISTRATEUR', NULL, 'Administrateur'),
(2, 'DIRECTEUR', NULL, 'Directeur'),
(3, 'SECRETAIRE', NULL, 'Secrétaire'),
(4, 'CHEF_PROJET', NULL, 'Chef de Projet'),
(5, 'COMPTABLE', NULL, 'Comptable'),
(6, 'TECHNICIEN', NULL, 'Technicien'),
(7, 'INGENIEUR', NULL, 'Ingénieur'),
(8, 'EMPLOYE', NULL, 'Employé');

-- --------------------------------------------------------

--
-- Structure de la table `projet`
--

CREATE TABLE `projet` (
  `id` int(11) NOT NULL,
  `dateDebut` date DEFAULT NULL,
  `dateFin` date DEFAULT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `Chef_de_projet` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `projet`
--

INSERT INTO `projet` (`id`, `dateDebut`, `dateFin`, `nom`, `Chef_de_projet`) VALUES
(1, '2013-01-14', '2013-12-31', 'Gestion de stock', 1);

-- --------------------------------------------------------

--
-- Structure de la table `projets`
--

CREATE TABLE `projets` (
  `id` bigint(20) NOT NULL,
  `code` varchar(50) NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `description` text DEFAULT NULL,
  `montant` double NOT NULL,
  `nom` varchar(200) NOT NULL,
  `statut` enum('ANNULE','CLOTURE','EN_COURS','SUSPENDU') DEFAULT NULL,
  `chef_projet_id` bigint(20) DEFAULT NULL,
  `organisme_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `projets`
--

INSERT INTO `projets` (`id`, `code`, `date_debut`, `date_fin`, `description`, `montant`, `nom`, `statut`, `chef_projet_id`, `organisme_id`) VALUES
(1, 'PRJ001', '2024-01-15', '2024-12-31', 'Développement d\'un système informatique complet pour la gestion des abonnés électricité : souscription, facturation, réclamations et suivi de consommation.', 850000, 'Système de Gestion des Abonnés ONE', 'EN_COURS', 6, 1),
(2, 'PRJ002', '2024-03-01', '2025-06-30', 'Création d\'une plateforme numérique nationale pour la gestion des dossiers médicaux électroniques, téléconsultation et suivi des patients à distance.', 2400000, 'Plateforme E-Santé Nationale', 'EN_COURS', 7, 2),
(3, 'PRJ003', '2023-06-01', '2024-05-31', 'Refonte complète du système d\'information de la commune : état civil numérique, gestion du patrimoine, portail citoyen et tableau de bord décisionnel.', 1200000, 'Modernisation du SI Communal de Fès', 'CLOTURE', 6, 3),
(4, 'PRJ004', '2024-05-01', '2025-03-31', 'Déploiement et optimisation de l\'infrastructure réseau fibre optique dans 5 villes : installation, configuration et tests de performance.', 3100000, 'Infrastructure Réseau Maroc Telecom', 'EN_COURS', 7, 4),
(5, 'PRJ005', '2023-09-01', '2024-08-31', 'Développement d\'un module RH intégré : gestion des congés, paie automatisée, évaluations de performance et formation en ligne.', 980000, 'Digitalisation OCP — Module RH', 'CLOTURE', 6, 5);

-- --------------------------------------------------------

--
-- Structure de la table `tache`
--

CREATE TABLE `tache` (
  `id` int(11) NOT NULL,
  `dateFin` date DEFAULT NULL,
  `datedebut` date DEFAULT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `prix` double DEFAULT NULL,
  `projet_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `tache`
--

INSERT INTO `tache` (`id`, `dateFin`, `datedebut`, `nom`, `prix`, `projet_id`) VALUES
(1, '2013-02-01', '2013-01-15', 'Analyse', 1200, 1),
(2, '2013-02-15', '2013-02-02', 'Conception', 1500, 1),
(3, '2013-03-30', '2013-02-16', 'Développement', 2500, 1);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `affectations`
--
ALTER TABLE `affectations`
  ADD PRIMARY KEY (`employe_id`,`phase_id`),
  ADD KEY `FK633qvx920p85xa35qbiim9h9` (`phase_id`);

--
-- Index pour la table `commentaires`
--
ALTER TABLE `commentaires`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK2jqtx8e1nrsg0l4t2yenmgnj7` (`auteur_id`),
  ADD KEY `FK4o900ctqk2s9a6gkyw707cm4c` (`phase_id`),
  ADD KEY `FKib67fah7mss4ave379ofpf2mr` (`projet_id`);

--
-- Index pour la table `documents_projet`
--
ALTER TABLE `documents_projet`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK6qii8vuoc12higqtn9gnxc9n3` (`projet_id`);

--
-- Index pour la table `employe`
--
ALTER TABLE `employe`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `employes`
--
ALTER TABLE `employes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UKqp1xdctrhyfc8b869xjs64m75` (`login`),
  ADD UNIQUE KEY `UKqiuyb191hjkemu1mnj7n5g4bc` (`matricule`),
  ADD UNIQUE KEY `UK3v0uyo0bds0i1s553pjkiewvv` (`email`),
  ADD KEY `FKn9elye4e4dird8qoao0s4nvy5` (`profil_id`);

--
-- Index pour la table `employetache`
--
ALTER TABLE `employetache`
  ADD PRIMARY KEY (`employe_id`,`tache_id`),
  ADD KEY `FK82gyt40ohsj3n4oc08x5id1d6` (`tache_id`);

--
-- Index pour la table `factures`
--
ALTER TABLE `factures`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UKb9kis2r730sywpxw7hw0j4gqh` (`code`),
  ADD UNIQUE KEY `UKto5a6fuwju3ony8d6lif3hvet` (`phase_id`);

--
-- Index pour la table `livrables`
--
ALTER TABLE `livrables`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKpp1rhrjelc995xbilvc70c6r4` (`phase_id`);

--
-- Index pour la table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK1trswd5cqgj5usjl50d6gcsx7` (`employe_id`);

--
-- Index pour la table `organismes`
--
ALTER TABLE `organismes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UKlvvnoayhy67vbj1sdsjwcwjng` (`code`);

--
-- Index pour la table `phases`
--
ALTER TABLE `phases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKcjf8ya8drmry0i393s7pi9mf5` (`projet_id`);

--
-- Index pour la table `profils`
--
ALTER TABLE `profils`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UKsohue06gag2e86h9scarbtgpg` (`code`);

--
-- Index pour la table `projet`
--
ALTER TABLE `projet`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK2ecr47cd2qs5ghq5yawcnrocf` (`Chef_de_projet`);

--
-- Index pour la table `projets`
--
ALTER TABLE `projets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UKll0oip1a94hosgf27pm86dice` (`code`),
  ADD KEY `FKmk1vi6j7k56mvcg0o1k1mhci7` (`chef_projet_id`),
  ADD KEY `FKbfaxpg242aqe07niio3xf9y69` (`organisme_id`);

--
-- Index pour la table `tache`
--
ALTER TABLE `tache`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKcb0x7p6kcs8h6ijwif67qdj9b` (`projet_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `commentaires`
--
ALTER TABLE `commentaires`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `documents_projet`
--
ALTER TABLE `documents_projet`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `employe`
--
ALTER TABLE `employe`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `employes`
--
ALTER TABLE `employes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `factures`
--
ALTER TABLE `factures`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `livrables`
--
ALTER TABLE `livrables`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `organismes`
--
ALTER TABLE `organismes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `phases`
--
ALTER TABLE `phases`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT pour la table `profils`
--
ALTER TABLE `profils`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT pour la table `projet`
--
ALTER TABLE `projet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `projets`
--
ALTER TABLE `projets`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `tache`
--
ALTER TABLE `tache`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `affectations`
--
ALTER TABLE `affectations`
  ADD CONSTRAINT `FK633qvx920p85xa35qbiim9h9` FOREIGN KEY (`phase_id`) REFERENCES `phases` (`id`),
  ADD CONSTRAINT `FK9pqluywvd0vi297w64ww0xqrc` FOREIGN KEY (`employe_id`) REFERENCES `employes` (`id`);

--
-- Contraintes pour la table `commentaires`
--
ALTER TABLE `commentaires`
  ADD CONSTRAINT `FK2jqtx8e1nrsg0l4t2yenmgnj7` FOREIGN KEY (`auteur_id`) REFERENCES `employes` (`id`),
  ADD CONSTRAINT `FK4o900ctqk2s9a6gkyw707cm4c` FOREIGN KEY (`phase_id`) REFERENCES `phases` (`id`),
  ADD CONSTRAINT `FKib67fah7mss4ave379ofpf2mr` FOREIGN KEY (`projet_id`) REFERENCES `projets` (`id`);

--
-- Contraintes pour la table `documents_projet`
--
ALTER TABLE `documents_projet`
  ADD CONSTRAINT `FK6qii8vuoc12higqtn9gnxc9n3` FOREIGN KEY (`projet_id`) REFERENCES `projets` (`id`);

--
-- Contraintes pour la table `employes`
--
ALTER TABLE `employes`
  ADD CONSTRAINT `FKn9elye4e4dird8qoao0s4nvy5` FOREIGN KEY (`profil_id`) REFERENCES `profils` (`id`);

--
-- Contraintes pour la table `employetache`
--
ALTER TABLE `employetache`
  ADD CONSTRAINT `FK82gyt40ohsj3n4oc08x5id1d6` FOREIGN KEY (`tache_id`) REFERENCES `tache` (`id`),
  ADD CONSTRAINT `FKcm4rkn43oh0spc9dnt7m6gdmt` FOREIGN KEY (`employe_id`) REFERENCES `employe` (`id`);

--
-- Contraintes pour la table `factures`
--
ALTER TABLE `factures`
  ADD CONSTRAINT `FKlfyhwqdq02wwgdieae1dv13d1` FOREIGN KEY (`phase_id`) REFERENCES `phases` (`id`);

--
-- Contraintes pour la table `livrables`
--
ALTER TABLE `livrables`
  ADD CONSTRAINT `FKpp1rhrjelc995xbilvc70c6r4` FOREIGN KEY (`phase_id`) REFERENCES `phases` (`id`);

--
-- Contraintes pour la table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `FK1trswd5cqgj5usjl50d6gcsx7` FOREIGN KEY (`employe_id`) REFERENCES `employes` (`id`);

--
-- Contraintes pour la table `phases`
--
ALTER TABLE `phases`
  ADD CONSTRAINT `FKcjf8ya8drmry0i393s7pi9mf5` FOREIGN KEY (`projet_id`) REFERENCES `projets` (`id`);

--
-- Contraintes pour la table `projet`
--
ALTER TABLE `projet`
  ADD CONSTRAINT `FK2ecr47cd2qs5ghq5yawcnrocf` FOREIGN KEY (`Chef_de_projet`) REFERENCES `employe` (`id`);

--
-- Contraintes pour la table `projets`
--
ALTER TABLE `projets`
  ADD CONSTRAINT `FKbfaxpg242aqe07niio3xf9y69` FOREIGN KEY (`organisme_id`) REFERENCES `organismes` (`id`),
  ADD CONSTRAINT `FKmk1vi6j7k56mvcg0o1k1mhci7` FOREIGN KEY (`chef_projet_id`) REFERENCES `employes` (`id`);

--
-- Contraintes pour la table `tache`
--
ALTER TABLE `tache`
  ADD CONSTRAINT `FKcb0x7p6kcs8h6ijwif67qdj9b` FOREIGN KEY (`projet_id`) REFERENCES `projet` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
