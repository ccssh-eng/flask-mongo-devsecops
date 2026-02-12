flask-mongo-devsecops

Projet DevSecOps complet - CI/CD, Qualité, Sécurité et Infrastructure as Code

Présentation

flask-mongo-devsecops est un projet démontrant la mise en œuvre complète et réaliste d’une chaîne
DevSecOps moderne autour d’une application Flask connectée à MongoDB.

L’objectif n’est pas seulement de faire fonctionner une application, mais de :
-	garantir la qualité du code
-	automatiser les tests
-	sécuriser les secrets
-	industrialiser les builds
-	maîtriser le déploiement Kubernetes
-	intégrer le monitoring
Ce projet reflète des problématiques terrain, rencontrées en environnement professionnel.

Objectifs DevSecOps

-	CI automatisée (lint, tests, qualité)
-	Analyse de code statique avec SonarQube
-	CD via Jenkins
-	Conteneurisation Docker
-	Orchestration Kubernetes (Minikube)
-	Infrastructure as Code (Ansible)
-	Monitoring (Prometheus & Grafana)
-	Gestion sécurisée des credentials

 Architecture globale

Développer ---git push-------> GitHub dépôt (privé) -----> GitHub Actions (CI) - Lint, Tests, Docker build  ----> 

----> Jenkins (Docker) (CI) - Lint/Tests, SonarQube scan, Docker push --->
                                                                    
                                                                    
----> Kubernetes(Minikube) - Flask API, MongoDB, SonarQube ----------> Monitoring - Promethus, Grafana
            
            
            
Stack technique

Domaine	               Outils

Backend	          Flask (Python)
Base de données	  MongoDB
Tests	          Pytest
Lint	          Flake8
Conteneurisation  Docker
Orchestration	  Kubernetes (Minikube)
CI	          GitHub Actions
CD	          Jenkins
Qualité	          SonarQube
IaC	          Ansible
Monitoring	  Prometheus, Grafana

CI / CD - Vue d’ensemble
CI - GitHub Actions

-	Lint Python
-	Tests unitaires
-	Build image Docker
-	Push vers Docker Hub (dépôt privé)

CD - Jenkins
-	Clonage du dépôt privé GitHub
-	Exécution des tests
-	Analyse SonarQube
-	Build et push Docker
-	Déploiement Kubernetes
=> Séparation volontaire CI / CD.

 SonarQube - Rôle et intégration

Rôle
-	Analyse statique du code Python
-	Détection de bugs, code smells, vulnérabilités
-	Suivi de la dette technique
-	Quality Gate avant déploiement

Choix : SonarQube interne (local)
SonarQube est déployé dans Kubernetes (Minikube) pour :

-	garder un environnement autonome
-	éviter toute dépendance cloud
-	maîtriser les flux réseau

Contraintes réseau (Linux)

-	Jenkins s’exécute dans Docker
-	SonarQube s’exécute dans Kubernetes
-	Les réseaux Docker et Kubernetes sont isolés
-	La communication Jenkins vers SonarQube est réalisée via :
 kubectl port-forward -n sonarqube svc/sonarqube 9000:9000   --address 0.0.0.0
-	Jenkins accède alors à SonarQube via l’IP du bridge Docker (docker0).
 
Ouverture future (OVH / Ingress)

En production :
-	SonarQube serait exposé via Ingress
-	DNS public (OVH)
-	TLS (Let’s Encrypt)
-	Authentification centralisée

Docker & Docker Compose

-	Image Flask optimisée
-	Jenkins customisé :
-	Python + venv (PEP 668)
-	Sonar Scanner
-	Docker CLI
-	Montage du socket Docker pour permettre les builds

 Kubernetes (Minikube)

-	Deployment Flask
-	Service NodePort
-	ConfigMaps pour variables d’environnement
-	Secrets pour MongoDB URI
-	Namespace dédié pour SonarQube
-	Déploiement reproductible

 Ansible - Infrastructure as Code

Playbooks fournis pour :
-	Installation Docker
-	Installation Kubernetes (kubectl + minikube)
-	Déploiement applicatif
-	Déploiement Jenkins
-	Approche idempotente

 Monitoring

-	Prometheus via Helm
-	Grafana via Helm
-	Dashboards custom
-	Namespace monitoring
-	Séparation claire applicatif / monitoring

 Sécurité & secrets

-	Tokens GitHub (dépôt privé)
-	Tokens SonarQube
-	Tokens Docker Hub
-	Aucun secret en clair dans le code
-	Jenkins Credentials Store
-	Secrets Kubernetes

Security Measures

- Pas de hardcoded secrets
- .env exclué via .gitignore
- Branch protection rules enabled
- Secure dependency management

Security Features

- Environment-based configuration
- Dependency vulnerability scanning
- Secure Docker container (non-root)

 Commandes clés

Lancer la stack locale

     docker compose up -d

Démarrer Kubernetes
    
     minikube start driver=docker

Déployer l’application

     kubectl apply -f   k8s/

Port-forward SonarQube

     kubectl   port-forward   -n sonarqube   svc/sonarqube 9000:9000   --address 0.0.0.0

 Leçons Appris 

-	Jenkins en conteneur nécessite un environnement maîtrisé
-	PEP 668 impose l’usage de virtualenv en CI
-	Le réseau Docker <---> Kubernetes est un vrai sujet sous Linux
-	SonarQube nécessite une réflexion d’exposition claire
-	Supprimer et recréer un job Jenkins est parfois plus sain que réparer
-	La documentation fait partie intégrante du DevSecOps

 Axes d’amélioration

-	Déploiement Kubernetes sur cluster cloud (OVH)
-	Ingress public avec TLS
-	Sécurité réseau avancée (NetworkPolicy)
-	Scan de vulnérabilités images (Trivy)
-	GitOps (ArgoCD)
                       
