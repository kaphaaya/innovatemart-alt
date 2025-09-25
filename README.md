InnovateMart Retail Store (Project Bedrock)

Project Overview

This project demonstrates the end-to-end deployment of a retail store application, InnovateMart, on AWS. The solution integrates a frontend site, relational and NoSQL databases, caching, and messaging services — all orchestrated on **Amazon EKS (Kubernetes)**.

Infrastructure was provisioned using **Terraform**, deployments automated with a **GitHub Actions pipeline (innovatemartci)**, and functionality verified using **AWS CLI** and kubectl.

This deployment showcases a real-world e-commerce architecture with a strong emphasis on cloud-native orchestration and **Infrastructure as Code (IaC)**.

---

## Architecture

**Frontend (InnovateMart Site)**

* A containerized web interface deployed as a Kubernetes pod.
* Exposed via a **LoadBalancer** (`frontend-service`).

**Databases**

* PostgreSQL (`innovatemart-orders`) on RDS
* MySQL (`innovatemart-catalog`) on RDS
* DynamoDB local instance inside the cluster

**Caching & Messaging**

* Redis for in-memory caching
* RabbitMQ for message brokering

**Storage**

* S3 bucket: `innovatemart-test-bucket-4d8550a1`

**Orchestration**

* AWS EKS Cluster, Kubernetes v1.32.8

**CI/CD**

* GitHub Actions workflow (`innovatemartci`) triggers Terraform plan & apply for automated infrastructure provisioning

---

## Repository Structure

```
innovatemart-alt/
├── infra/                  # Terraform IaC
│   ├── main.tf
│   ├── .terraform.lock.hcl
│   └── terraform.tfstate*
├── k8s-manifests/          # Kubernetes manifests
│   ├── frontend-deployment.yaml
│   ├── frontend-service.yaml
│   ├── postgres-deployment.yaml
│   ├── mysql-deployment.yaml
│   ├── redis-deployment.yaml
│   ├── rabbitmq-deployment.yaml
│   └── dynamodb-local.yaml
├── site/                   # Frontend static site
│   ├── index.html
│   ├── assets/
│   └── styles/
├── screenshots/            # Evidence of deployment
│   ├── eks-cluster.png
│   ├── rds-postgres.png
│   ├── rds-mysql.png
│   ├── s3-bucket.png
│   ├── frontend-service.png
│   └── live-site.png
├── .github/workflows/      # CI/CD pipeline
│   └── ci.yml
├── Dockerfile
├── eks-readonly-policy.json
├── .gitignore
└── README.md
```

---

## AWS Resources Deployed

| Resource               | Identifier / Notes                                                                             |
| ---------------------- | ---------------------------------------------------------------------------------------------- |
| S3 Bucket              | innovatemart-test-bucket-4d8550a1                                                              |
| PostgreSQL RDS         | innovatemart-orders.cf6qekgoqyk2.eu-west-1.rds.amazonaws.com                                   |
| MySQL RDS              | innovatemart-catalog.cf6qekgoqyk2.eu-west-1.rds.amazonaws.com                                  |
| DynamoDB               | Local instance on port 8000                                                                    |
| EKS Cluster Nodes      | ip-192-168-32-239, ip-192-168-77-107                                                           |
| Kubernetes Deployments | frontend, mysql, postgres, redis, rabbitmq, dynamodb-local                                     |
| LoadBalancer           | [Frontend URL](http://aa56cf440d34944c7bbb8064973f4c11-2041984845.eu-west-1.elb.amazonaws.com) |
| Final Application      | InnovateMart Frontend ✅ Live                                                                   

Update kubeconfig
aws eks update-kubeconfig --name innovate-mart-eks --region eu-west-1 --role-arn arn:aws:iam::<account_id>:role/InnovateMartReadOnly
kubectl get pods -n retail-store
kubectl get svc -n retail-store
```

The read-only IAM user has permissions to view EKS resources, RDS endpoints, and S3 objects, but cannot modify infrastructure.

---

Challenges & Lessons Learned

-EKS Cluster Creation Issues:** Deprecated arguments in Terraform & eksctl resolved by updating configs.

-Terraform CI/CD Errors:** Initial GitHub Actions failed due to missing IAM permissions; fixed by scoped IAM user and GitHub Secrets.

-Database Restrictions:** PostgreSQL passwords initially rejected special characters; adjusted policy.

-Port Conflicts:** DynamoDB local failed on port 8000; fixed by freeing the port.

-IAM Least Privilege:** Restricted CI/CD role to only required resources.

-Manual to Automated Deployment:** Manual deployment for clarity → fully automated via Terraform & GitHub Actions.

---

References

* AWS Documentation (EKS, RDS, S3, DynamoDB)
* Terraform AWS Provider Docs
* Kubernetes Official Documentation


