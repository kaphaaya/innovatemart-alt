InnovateMart Retail Store (Project Bedrock)
Project Overview

This project demonstrates the end-to-end deployment of a retail store application 
called InnovateMart on AWS. The solution integrates frontend, databases, caching, 
and messaging services, all running on Kubernetes (EKS). 
Infrastructure was provisioned using Terraform, automated with a dedicated CI/CD pipeline 
(innovatemartci), and verified using the AWS CLI.

The deployment showcases a real-world e-commerce architecture, with a focus on 
cloud-native orchestration and infrastructure as code.



Architecture

Frontend (InnovateMart Site):
A functioning Retail store web interface served by the frontend pod and exposed via a Kubernetes LoadBalancer (frontend-service).



Databases:

PostgreSQL (innovatemart-orders) on RDS

MySQL (innovatemart-catalog) on RDS

DynamoDB local instance (dynamodb-local)

Caching & Messaging:

Redis (redis)

RabbitMQ (rabbitmq)



Storage: S3 bucket (innovatemart-test-bucket-4d8550a1)

Orchestration: AWS EKS cluster running Kubernetes v1.32.8

CI/CD: GitHub Actions pipeline (innovatemartci) triggers Terraform workflows for infrastructure provisioning.



Folder Structure

The repository is organized as follows:

innovatemart/
│
├── terraform/                  # Terraform IaC files
│   ├── main.tf                 # Main infrastructure configuration
│   ├── variables.tf            # Input variables
│   ├── outputs.tf              # Outputs (RDS endpoints, S3 names, etc.)
│   ├── backend.tf              # Remote backend configuration (S3 + DynamoDB lock)
│   └── provider.tf             # AWS provider setup
│
├── k8s-manifests/              # Kubernetes resource definitions
│   ├── frontend-deployment.yaml
│   ├── frontend-service.yaml
│   ├── postgres-deployment.yaml
│   ├── mysql-deployment.yaml
│   ├── redis-deployment.yaml
│   ├── rabbitmq-deployment.yaml
│   └── dynamodb-local.yaml
│
├── .github/workflows/          # GitHub Actions CI/CD
│   └── terraform-ci.yml        # Runs terraform plan & apply
│
├── logs/                       # Captured logs/screenshots from testing
│   ├── terraform-apply.log
│   └── kubectl-outputs.txt
│
└── README.md                   # Project documentation



AWS Resources Deployed

-Resource	Name / Identifier	Notes
-S3 Bucket	innovatemart-test-bucket-4d8550a1	Created by Terraform pipeline (innovatemartci)
-PostgreSQL RDS	innovatemart-orders.cf6qekgoqyk2.eu-west-1.rds.amazonaws.com	Verified via connectivity tests inside frontend pod
-MySQL RDS	innovatemart-catalog.cf6qekgoqyk2.eu-west-1.rds.amazonaws.com	Verified via connectivity tests inside frontend pod
-DynamoDB	dynamodb-local	Local instance exposed on port 8000
-EKS Cluster Nodes	ip-192-168-32-239, ip-192-168-77-107	Kubernetes v1.32.8-eks-99d6cc0
-Kubernetes Deployments	frontend, mysql, postgres, dynamodb-local, redis, rabbitmq	All verified running
-LoadBalancer	frontend-service	URL: http://aa56cf440d34944c7bbb8064973f4c11-2041984845.eu-west-1.elb.amazonaws.com
-Final Application URL
InnovateMart Frontend Site (via LoadBalancer):
http://aa56cf440d34944c7bbb8064973f4c11-2041984845.eu-west-1.elb.amazonaws.com



Challenges & Lessons Learned

-EKS Cluster Creation Issues: Encountered several deprecated arguments (Terraform AWS provider and eksctl changed parameter naming). Required modifying cluster creation configuration to align with the updated provider versions.

-Terraform CI/CD Errors: Initial pipeline runs failed due to IAM permission gaps. Resolved by creating a scoped IAM user and saving its credentials in GitHub Secrets.

-Database Restrictions: PostgreSQL rejected passwords with special characters (e.g., @). Adjusted password policy to allow a valid but secure password.

-Port Conflicts: DynamoDB local service initially failed due to port 8000 being in use; fixed by freeing the port.

-IAM Least Privilege: Applied principle of least privilege, restricting CI/CD role to EKS, RDS, S3, DynamoDB, CloudFormation, and Secrets Manager.


Manual to Automated: Began with manual deployment for clarity before automating with Terraform through CI/CD.



References

AWS Documentation (EKS, RDS, S3, DynamoDB)

Terraform AWS Provider Docs

Kubernetes Official Documentation
