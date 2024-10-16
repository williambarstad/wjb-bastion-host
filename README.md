# AWS Highly Available Web Application with Bastion Host

> Work In Progress
## Overview
This project sets up a highly available web application in AWS, utilizing multiple services to achieve scalability, redundancy, and secure management. It uses Terraform to automate the deployment of resources such as Virtual Private Cloud (VPC), subnets, NAT Gateway, Application Load Balancer (ALB), Auto Scaling Group (ASG), bastion host, and web servers.

## Components
1. **VPC**: A Virtual Private Cloud to logically isolate the AWS infrastructure.
2. **Subnets**:
   - **Public Subnets**: For Application Load Balancer (ALB), bastion host, and NAT Gateway.
   - **Private Subnets**: For web servers running the application.
3. **Internet Gateway (IGW)**: Allows resources in the public subnets to connect to the internet.
4. **NAT Gateway**: Provides outbound internet access to resources in private subnets.
5. **Route Tables**:
   - **Public Route Table**: Routes traffic to/from public subnets.
   - **Private Route Table**: Routes private subnet traffic to the NAT Gateway.
6. **Application Load Balancer (ALB)**: Distributes incoming traffic across web servers for high availability.
7. **Auto Scaling Group (ASG)**: Ensures that a sufficient number of web servers are always running across multiple Availability Zones (AZs).
8. **Bastion Host**: A secure entry point for SSH access to instances in private subnets.
9. **Web Servers**: EC2 instances managed by the ASG, running the web application.

## File Structure
- **main.tf**: Defines the main resources for setting up the infrastructure.
- **variables.tf**: Contains the input variables used in the project.
- **providers.tf**: Configures the AWS provider for the deployment.
- **web.tf**: Defines the web server resources, including the Auto Scaling Group and launch configuration.
- **alb.tf**: Configures the Application Load Balancer, listener, and target group.
- **bastion.tf**: Defines the bastion host for secure access.

## Prerequisites
- **Terraform** installed on your local machine.
- **AWS CLI** configured with appropriate access credentials.
- An **SSH key pair** to access the bastion host.

## Setup Instructions
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/williambarstad/K8sLab-TF.git
   cd K8sLab-TF
   ```

2. **Initialize Terraform**:
   ```bash
   terraform init
   ```

3. **Set Up Variables**:
   Update the `variables.tf` file or create a `terraform.tfvars` file to customize input values, such as AWS region, instance type, and SSH key pair.

4. **Plan the Infrastructure**:
   ```bash
   terraform plan
   ```
   Review the output to ensure that the infrastructure changes match your expectations.

5. **Apply the Configuration**:
   ```bash
   terraform apply
   ```
   Confirm the prompt to create the resources.

## Key Considerations
- **High Availability**: Instances are deployed across multiple AZs to ensure availability during AZ failures.
- **Security**: The bastion host provides controlled SSH access to the private instances, while the web servers are protected from direct public access.
- **Cost Optimization**: Consider strategies to minimize NAT Gateway costs, such as using VPC Endpoints for AWS services and consolidating NAT Gateways.

## Diagram
The infrastructure includes:
- An **Internet Gateway** connected to public subnets, allowing external access.
- A **NAT Gateway** in a public subnet, providing outbound internet access to private resources.
- **ALB** routing traffic to web servers in private subnets for redundancy and scalability.
- **Bastion Host** for secure management of resources in private subnets.

Refer to the provided architecture diagram for a visual representation.

## Optimization Tips
- **NAT Gateway Costs**: Consolidate NAT Gateways or replace them with NAT Instances if appropriate to reduce costs.
- **Use VPC Endpoints**: Set up VPC Endpoints for services like S3 and DynamoDB to reduce the dependency on the NAT Gateway and cut costs.

## Cleanup
To delete all resources created by this project:
```bash
terraform destroy
```
Ensure that you no longer need the infrastructure before running this command.

## License
This project is licensed under the MIT License. Feel free to use, modify, and distribute it as needed.

## Author
- **William Barstad** - [willismbarstad.com](https://williambarstad.com)

## Contact
If you have any questions, please feel free to reach out at william@williambarstad.com.

