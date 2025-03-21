-- Création de la base de données
CREATE DATABASE chelsea_club;
USE chelsea_club;

-- Table des utilisateurs
CREATE TABLE users (
    Id_user INT AUTO_INCREMENT PRIMARY KEY,
    pseudo VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(250) NOT NULL UNIQUE,
    mdp VARCHAR(255) NOT NULL,
    role BOOLEAN NOT NULL DEFAULT FALSE
);

-- Insertion d'un utilisateur admin
INSERT INTO users (pseudo, email, mdp, role)
VALUES ('admin', 'admin@chelsea.com', 'admin123', TRUE);

-- Table des catégories d'articles
CREATE TABLE categories (
    Id_categorie INT AUTO_INCREMENT PRIMARY KEY,
    nom_categorie VARCHAR(100) NOT NULL UNIQUE
);

-- Insertion de deux catégories
INSERT INTO categories (nom_categorie)
VALUES ('Nouvelles'), ('Mercato');

-- Table des articles
CREATE TABLE articles (
    Id_article INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(100) NOT NULL,
    contenu TEXT NOT NULL,
    date_creation DATE,
    Id_user INT,
    Id_categorie INT,
    FOREIGN KEY (Id_user) REFERENCES users(Id_user) ON DELETE CASCADE,
    FOREIGN KEY (Id_categorie) REFERENCES categories(Id_categorie) ON DELETE SET NULL
);

-- Insertion de deux articles par l'admin
INSERT INTO articles (titre, contenu, date_creation, Id_user, Id_categorie)
VALUES
    ('Chelsea remporte le match', 'Chelsea a sécurisé une victoire lors du dernier match contre ses rivaux.', CURDATE(), 1, 1),
    ('Nouvelle signature de joueur', 'Chelsea a signé un nouveau joueur pour renforcer l\'équipe.', CURDATE(), 1, 2);

-- Table pour les contacts
CREATE TABLE contact (
    Id_contact INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(250) NOT NULL,
    message TEXT NOT NULL,
    date_creation DATE
);

-- Table pour lier les utilisateurs aux contacts
CREATE TABLE formuler (
    Id_user INT,
    Id_contact INT,
    PRIMARY KEY(Id_user, Id_contact),
    FOREIGN KEY(Id_user) REFERENCES users(Id_user) ON DELETE CASCADE,
    FOREIGN KEY(Id_contact) REFERENCES contact(Id_contact) ON DELETE CASCADE
);

-- Table des commentaires
CREATE TABLE commentaires (
    Id_commentaire INT AUTO_INCREMENT PRIMARY KEY,
    date_creation DATE,
    contenu TEXT NOT NULL,
    Id_user INT,
    Id_article INT,
    FOREIGN KEY (Id_user) REFERENCES users(Id_user) ON DELETE CASCADE,
    FOREIGN KEY (Id_article) REFERENCES articles(Id_article) ON DELETE CASCADE
);

-- Table pour les réponses aux commentaires
CREATE TABLE repondre (
    Id_commentaire_parent INT,
    Id_commentaire INT,
    PRIMARY KEY(Id_commentaire_parent, Id_commentaire),
    FOREIGN KEY(Id_commentaire_parent) REFERENCES commentaires(Id_commentaire) ON DELETE CASCADE,
    FOREIGN KEY(Id_commentaire) REFERENCES commentaires(Id_commentaire) ON DELETE CASCADE
);

-- Table pour les bannissements
CREATE TABLE banissements (
    Id_banissement INT AUTO_INCREMENT PRIMARY KEY,
    raison VARCHAR(250) NOT NULL,
    Id_user INT NOT NULL,
    Id_user_1 INT NOT NULL,
    FOREIGN KEY(Id_user) REFERENCES users(Id_user) ON DELETE CASCADE,
    FOREIGN KEY(Id_user_1) REFERENCES users(Id_user) ON DELETE CASCADE
);

-- Table pour les demandes de récupération de mot de passe
CREATE TABLE mdp_oublie (
    Id_mot_passe_oublie INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(250) NOT NULL,
    date_demande DATE,
    Id_user INT,
    FOREIGN KEY(Id_user) REFERENCES users(Id_user) ON DELETE SET NULL
);
