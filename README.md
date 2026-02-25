#DevSecOps GitOps Platform

## Architecture

- OVH Managed Kubernetes
- Terraform Infrastructure
- GitOps via ArgoCD
- CI via Jenkins
- SonarQube Quality Gate
- Prometheus + Grafana Monitoring
- Ingress NGINX (NodePort, no LoadBalancer cost)

## Workflow

feature → main → DEV auto deploy
validation OK
main → prod → PROD auto deploy
PROD smoke test
auto rollback if failure

## Branch Strategy

- main = DEV
- prod = PROD

## Disaster Recovery

- terraform destroy
- terraform apply
- ArgoCD auto sync
- Git-based rollback

## Security

- ResourceQuota enforced
- CPU/Memory limits mandatory
- RBAC minimal per namespace
- No imagePullSecrets (public registry)

## Monitoring

- Prometheus scraping
- Grafana dashboards
- ArgoCD metrics
