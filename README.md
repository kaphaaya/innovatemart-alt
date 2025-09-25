InnovateMart Retail Store (Project Bedrock)
Project Overview

This project demonstrates the end-to-end deployment of a retail store application called InnovateMart on AWS.

The solution integrates a frontend site, relational and NoSQL databases, caching, and messaging services — all orchestrated on Amazon EKS (Kubernetes).

Infrastructure was provisioned using Terraform, deployments automated with a GitHub Actions pipeline (innovatemartci), and functionality verified using the AWS CLI and kubectl.

The deployment showcases a real-world e-commerce architecture with a strong emphasis on cloud-native orchestration and infrastructure as code (IaC).



Architecture

Frontend (InnovateMart Site)
A working e-commerce web interface, containerized and deployed as a Kubernetes pod, exposed via a LoadBalancer (frontend-service).



Databases

PostgreSQL (innovatemart-orders) on RDS

MySQL (innovatemart-catalog) on RDS

DynamoDB Local instance running inside the cluster

Caching & Messaging

Redis for in-memory caching

RabbitMQ for message brokering



Storage

S3 bucket: innovatemart-test-bucket-4d8550a1 for object storage



Orchestration

AWS EKS Cluster running Kubernetes v1.32.8

CI/CD

GitHub Actions workflow (innovatemartci) triggers Terraform plans and applies for automated infrastructure provisioning.



Repository Structure
innovatemart-alt/
├── infra/                  # Terraform infrastructure code
│   └── main.tf
│   └── .terraform.lock.hcl
│   └── terraform.tfstate
│   └── terraform.tfstate.backup
│
├── k8s-manifests/          # Kubernetes manifests for services & deployments
│   ├── frontend-deployment.yaml
│   ├── frontend-service.yaml
│   ├── postgres-deployment.yaml
│   ├── mysql-deployment.yaml
│   ├── redis-deployment.yaml
│   ├── rabbitmq-deployment.yaml
│   └── dynamodb-local.yaml
│
├── site/                   # InnovateMart frontend static site
│   ├── index.html
│   ├── assets/
│   └── styles/
│
├── screenshots/            # Evidence of work (AWS Console, CLI, kubectl)
│   ├── eks-cluster.png
│   ├── rds-postgres.png
│   ├── rds-mysql.png
│   ├── s3-bucket.png
│   ├── frontend-service.png
│   └── live-site.png
│
├── .github/workflows/      # GitHub Actions pipeline
│   └── ci.yml
│
├── Dockerfile              # Docker build for frontend container
├── eks-readonly-policy.json # IAM policy applied to CI/CD user
├── .gitignore
└── README.md

AWS Resources Deployed
-Resource	Identifier / Notes
-S3 Bucket	innovatemart-test-bucket-4d8550a1
-PostgreSQL RDS	innovatemart-orders.cf6qekgoqyk2.eu-west-1.rds.amazonaws.com
-MySQL RDS	innovatemart-catalog.cf6qekgoqyk2.eu-west-1.rds.amazonaws.com
-DynamoDB	Local instance exposed on port 8000
-EKS Cluster Nodes	ip-192-168-32-239, ip-192-168-77-107
-Kubernetes Deploys	frontend, mysql, postgres, redis, rabbitmq, dynamodb-local
-LoadBalancer	http://aa56cf440d34944c7bbb8064973f4c11-2041984845.eu-west-1.elb.amazonaws.com
-Final Application	InnovateMart Frontend
 ✅ Live


Challenges & Lessons Learned

-EKS Cluster Creation Issues
Encountered deprecated arguments in Terraform AWS provider and eksctl. Resolved by aligning configs with updated versions.

-Terraform CI/CD Errors
Initial GitHub Actions runs failed due to missing IAM permissions. Solved by creating a scoped IAM user and storing credentials in GitHub Secrets.

-Database Restrictions
PostgreSQL RDS rejected special characters (e.g., @) in passwords. Adjusted password policy accordingly.

-Port Conflicts
DynamoDB local failed initially due to port 8000 in use; fixed by freeing the port.

-IAM Least Privilege
Implemented principle of least privilege, restricting CI/CD role to EKS, RDS, S3, DynamoDB, CloudFormation, and Secrets Manager.

-Manual to Automated Deployment
Began with manual setup for clarity → transitioned to full automation with Terraform and GitHub Actions.



References

AWS Documentation: EKS, RDS, S3, DynamoDB

Terraform AWS Provider Docs

Kubernetes Official Documentation
