# SRE_Challenge 

For this repo, please refer to the "s3_backend.md" file, it contains the state initialization file for a remote backend using an S3 Bucket and a DynamoDB Table for state locking.

This is a work in progress repo, the features that still need to be added: 
- A readme for the modules 
- Importing modules to the root module 
- Variables for root 
- Miscellaneous revisions for mistakes

I created a user data script to ensure TLS 1.2 was enabled on the bastion host, opened port 3389, and tried to make it as modular as possible. 

This repo (when completed) will Deploy a 3-Tier Architecture to AWS including: 
- An Autoscaling Group for EC2 Web Server Instances running in multiple AZ's 
- A Bastion Host 
- An Application Load Balancer 
- A Cloud Watch Synthetics (Canary) Test 
- Multiple Subnets in Multiple AZ's
- A PostgreSQL Database
