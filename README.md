# AWS-Card-Clash-Library

This is a collection of Terraform scripts to build the architectures depicted in the AWS Card Clash learning game.

## How to use

1. Set up your AWS account and configure your AWS CLI. Terraform and the scripts provided will need working access to the AWS CLI.
2. Install Terraform or Open Tofu.
3. Clone this repository.
4. Go to the directory of the architecture you want to build. Navigate to the live-folder. Run `terraform init`, followed by `terraform apply`. This will build the architecture in your AWS account, tagging all resources with the tag corresponding to the architecture. This allows you to build multiple architectures in the same account side by side.
5. Run `terraform output` to get the outputs of the architecture, including URLs, IP addresses, and other information.
6. Review, modify and use the scripts in the `scripts` directory to interact with the architecture.
7. To delete the architecture, run `terraform destroy` in the same directory where you ran `terraform apply`. 


## Terraform State Management

To get started as quickly as possible, the Terraform state management is simplified and will be stored locally in each of the architecture directories. 

 Please do not work with multiple developers on the same architecture at the same time as the state will not be synchronized between the developers. 
 
This repository is only meant for learning purposes and not for production use. 

## Checklist for New Examples

- [ ] Add all resources of new architecture in a directory named after the architecture
- [ ] Tag all resources with the architecture tag (e.g. `architecture = "sd-01"` for the first example in the serverless developer track)
- [ ] Add README.md with screenshots of the architecture and cost estimation
- [ ] Add deployment diagram image with actual names of resources
- [ ] Add scripts to interact with the architecture, for example to upload data or test the architecture
