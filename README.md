# Cloud-Native Microservices with DevSecOps -  Online Boutique 


## Overview
This repository contains a fork of Google Cloud's **Online Boutique** demo application, extended with a full **DevSecOps pipeline** and secure infrastructure provisioning.  
The application is a web-based e-commerce platform where users can browse products, add them to a cart, and complete purchases. It is designed to demonstrate cloud-first microservices architecture, observability, and automated security practices.

---
## Rough Diagrams of Projects
### Diagram1(Infra POV)**
![PRODEVSECFD (1)](https://github.com/user-attachments/assets/688fc32d-9171-4f66-8448-4b554a8d585a) 
   

      
### Diagram2(DevOps POV)**  
![PROJECTDEVSECFDN_F](https://github.com/user-attachments/assets/536bf442-dc73-42d7-9a5f-cfad96ebbd3e)  
 

  
---

## Architecture Highlights 

- **Microservices:** 10+ services written in Go, C#, Node.js, Python, and Java.
- **CI/CD:** Jenkins pipelines for each microservice.
- **Security & Quality Gates:**
  - Static analysis: `gosec`, `bandit`
  - Code quality: SonarQube
  - Dependency scanning: OWASP Dependency Check, `govulncheck`, `python-safety`
  - File system scan: Trivy
  - Container image scan: Trivy
- **Containerization:** Docker builds pushed to AWS ECR.
- **Infrastructure:** Provisioned with Terraform (self-authored modules).
- **Observability:** Prometheus stack, Grafana, Alertmanager, and EFK (Elasticsearch, FluentBit, Kibana).
- **Scalability:** Horizontal Pod Autoscaler (HPA), Cluster Autoscaler.
- **Networking & Security:**
  - ALB Ingress Controller
  - EBS CSI Driver for dynamic storage
  - Route53 DNS records for services (`argocd.kenzopsify.site`, `shop.kenzopsify.site`, `prometheus.kenzopsify.site`, `grafana.kenzopsify.site`, `alertmanager.kenzopsify.site`, `kibana.kenzopsify.site`)
  - Bastion host in public subnet with hardened security groups and NACLs
  - EKS cluster in private subnets across multiple AZs
  - NAT gateway for controlled outbound traffic

---

## Microservices  

#### Flow
<img width="1436" height="784" alt="Screenshot 2025-11-11 120526" src="https://github.com/user-attachments/assets/527f1b67-f139-4612-817b-5a0c953cf10f" />  
  

| Service               | Language | Description                                                                 |
|------------------------|----------|-----------------------------------------------------------------------------|
| frontend              | Go       | Serves the website, generates session IDs automatically.                     |
| productcatalogservice | Go       | Provides product list and search functionality from JSON.                    |
| shippingservice       | Go       | Estimates shipping costs and simulates item delivery.                        |
| checkoutservice       | Go       | Orchestrates cart retrieval, payment, shipping, and email notification.      |
| cartservice           | C#       | Stores and retrieves cart items in Redis (backed by dynamic EBS volume).     |
| currencyservice       | Node.js  | Converts currency using ECB rates; highest QPS service.                      |
| paymentservice        | Node.js  | Simulates credit card charge and returns transaction ID.                     |
| emailservice          | Python   | Sends order confirmation emails (mock).                                      |
| recommendationservice | Python   | Suggests products based on cart contents.                                    |
| loadgenerator         | Python   | Generates realistic user traffic with Locust.                                |
| adservice             | Java     | Provides contextual text ads.                                                |

---

## DevSecOps Pipeline (Jenkinsfile)
Each microservice has its own Jenkinsfile implementing the following stages:

1. **Static Analysis** – `gosec` (Go), `bandit` (Python)
2. **Code Quality** – SonarQube scan
3. **Build & Unit Tests**
4. **Dependency Vulnerability Scan** – OWASP, `govulncheck`, `python-safety`
5. **File System Scan** – Trivy
6. **Docker Build**
7. **Image Scan** – Trivy
8. **Push to AWS ECR**
9. **Email Notifications** – Reports for every stage

---

## Infrastructure Provisioning (Terraform)
- **Modules:** Self-authored, modular, and security-focused.
- **Networking:**
  - Public subnets (2 AZs) with bastion host
  - Private subnets (2 AZs) for EKS and workloads
  - NAT gateway for outbound traffic
- **Security:**
  - NACLs with security measures and Security Groups for bastion, cluster, and node groups
  - Bastion host for controlled access (with userdata)
- **Storage:** EBS CSI driver for dynamic volume provisioning
- **Ingress:** ALB Ingress Controller for routing
- **DNS:** Route53 records for application and observability endpoints

---

## Observability & Monitoring
- **Prometheus Stack:** Metrics collection
- **Grafana:** Visualization dashboards
- **Alertmanager:** Alert routing
- **EFK Stack:** Centralized logging (Elasticsearch, Fluentbit, Kibana)

---

## Deployment & Operations
- **ArgoCD:** GitOps-based continuous delivery
- **Cluster Autoscaler:** Automatic scaling of node groups
- **Horizontal Pod Autoscaler (HPA):** Application-level scaling
- **Redis:** Backed by dynamic EBS volume for cart service

---

## Access Points
- Application: `shop.kenzopsify.site`
- ArgoCD: `argocd.kenzopsify.site`
- Prometheus: `prometheus.kenzopsify.site`
- Grafana: `grafana.kenzopsify.site`
- Alertmanager: `alertmanager.kenzopsify.site`
- Kibana: `kibana.kenzopsify.site`

---
## Operational Snapshots  
  
### Route53 Records  
<img width="1919" height="1079" alt="Screenshot 2025-11-02 072240" src="https://github.com/user-attachments/assets/dc6f0553-b841-4642-8c22-0904961d39f5" />  
  

### ArgoCD  
<img width="1918" height="1078" alt="Screenshot 2025-11-01 215552" src="https://github.com/user-attachments/assets/785866aa-05a6-45d2-b37b-a8b56d7fd0b5" />  
  

### Boutique Shop  
<img width="1918" height="1078" alt="Screenshot 2025-11-01 214950" src="https://github.com/user-attachments/assets/3a65487d-05e8-4f80-b968-fde88ea7aa95" />  
  

### Grafana  
<img width="1903" height="1077" alt="Screenshot 2025-11-01 214832" src="https://github.com/user-attachments/assets/3befd0a5-68ca-43dc-8628-8b12e01abe32" />   
  

### Prometheus  
<img width="1918" height="1078" alt="Screenshot 2025-11-01 215655" src="https://github.com/user-attachments/assets/66cd2e55-c3c8-481d-be90-51be2d47b916" />  

  
### AlertManager
<img width="1918" height="1078" alt="Screenshot 2025-11-01 215747" src="https://github.com/user-attachments/assets/a674dda1-50cc-4650-ab72-aa45c0f77187" />  
  

### Kibana  
<img width="1918" height="1078" alt="Screenshot 2025-11-02 042203" src="https://github.com/user-attachments/assets/10675f71-3a5d-4d11-acfb-2d310ad41398" />

For more Operational Snapshots Refer: **SNAPSHOT.md**


---

## Purpose
This project demonstrates:
- End-to-end DevSecOps practices
- Secure, modular infrastructure provisioning
- Cloud-native observability and scalability
- Multi-language microservices integration

It serves as a reference for building production-grade, secure, and observable microservices applications on AWS EKS.

---  

## 🔹 Key Features

- Multi-language microservices architecture (Go, Node.js, Python, Java, C#)  
- Secure, automated CI/CD pipelines  
- GitOps continuous deployment using ArgoCD  
- End-to-end vulnerability scanning (code, dependencies, containers)  
- Real-time monitoring and logging stack  
- Infrastructure security and isolation through Terraform-managed AWS resources  
- Scalable and fault-tolerant deployment model  

---

## 🔹 Future Enhancements

- Implement service mesh (Istio/Linkerd) for traffic management and zero-trust security  
- Add DAST scanning (OWASP ZAP) for runtime vulnerability detection  
- Create Jenkins Shared libraries that are reusabe for the other projects and the stages that didn't present in jenkins-shared-library Repo.


---

## 🔹 Author

**Kenz Muhammed C K**
GMAIL: kenzmuhammedc@gmail.com
💼 Finding balance between clean infrastructure, useful automation, and real-world simplicity.

 

---



## License
This repository is based on Google Cloud's Online Boutique demo.  
Refer to the original license for usage terms.
