# Architecture
![Screenshot of architecture](screenshot.png)

This architecture implements the best practice for running a single-page application on AWS. It uses only serverless services and is able to scale automatically.

# How to Deploy

1. Build infrastructure with `terraform apply`. Note the output values printed in the terminal by Terraform, as you will need them later.
2. Edit `scripts/assets/app.js` and provide your API Gateway URL which you got as output from the previous step. This URL is used to call the backend from the frontend.
3. Upload the simple web application by running `scripts/upload-simple-website.sh`. As a parameter, provide your Cloudfront distribution ID so that the script can invalidate the cache after the upload. The distribution ID is also an output value from the Terraform script, see step 1.
4. Open the web_app_cloudfront_distribution_domain_nam URL from step 1 in your browser and have fun with your fortune cookie app!


# Cost Estimation

The following cost estimates were created using the [AWS Pricing Calculator](https://calculator.aws/). They  only provide a rough estimate, actual costs may vary.

Region used: eu-central-1 (Frankfurt)

**Date of Estimation: 2024-12-11**

| AWS Service | Example Scenario 1: Small                                                                                                                 | Example Scenario 2: Medium | Example Scenario 3: Large |
|-------------|-------------------------------------------------------------------------------------------------------------------------------------------|----------------------------|---------------------------|
| S3          | 0,01 GB stored in 10 files<br />30 uploads per month,<br />10 requests per day = 10 x 10 x 30 = 3.000 per month = 3 GB<br /><br />0.1 USD | todo                       | todo                      |
| CloudFront  | 3 GB data out,<br />3.000 requests<br /><br />0.26 USD                                                                                    |                            |                           |
| **Total**   | **0.27 USD**                                                                                                                              | **todo**                   | **todo**                  ||
