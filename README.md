# SRE_Challenge 

For this repo, please refer to the "s3_backend.md" file, it contains the state initialization file for a remote backend using an S3 Bucket and a DynamoDB Table.

For this project I made use of these sources: 
https://github.com/brikis98/terraform-up-and-running-code
https://github.com/terraform-in-action/manning-code/blob/master/chapter4/complete/modules/autoscaling/main.tf
https://www.terraform.io/cloud-docs/guides/recommended-practices 
https://github.com/ozbillwang/terraform-best-practices/blob/master/s3-backend/main.tf 
https://dirteam.com/sander/2019/07/30/howto-disable-weak-protocols-cipher-suites-and-hashing-algorithms-on-web-application-proxies-ad-fs-servers-and-windows-servers-running-azure-ad-connect/
https://stackoverflow.com/questions/64371831/trying-to-create-an-aws-route53-record-to-point-to-a-load-balancer-but-keep-gett 

I had some issues executing this project, the pressure of the time contraint was a large factor, but there were other parts of the code implementation I couldn't figure out as well. 
For example, it was requested that I add 20 GB of storage to multiple EC2 Instances, but in an effort to adhere to the SLA requirements I placed the EC2 Instances within an ASG, 
which did not give me the option to provision teh standard EBS volumes. I later realized that a good solution to this would be an EFS, but I had so much tunnel vision with everything else that it was neglected. This was my first time attmepting to write secure code in mass, so there are bound to be mistakes, but I attempted 
to implement every option listed. 

I created a user data script to ensure TLS 1.2 was enabled on the bastion host, opened port 3389, and tried to make it as modular as possible. 
