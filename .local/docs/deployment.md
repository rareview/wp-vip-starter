# Deployment

The deployment process is handled by [Circle CI](https://circleci.com/). 

Please ensure that the `.circleci/config.tbd` file is renamed to `.circleci/config.yml` and that it is properly configured for the deployment process.

Please ensure that the files in the `config` directory are renamed and configured according to the client's needs.

The deployment process is triggered when a new commit is pushed to the `master` branch or a PR is done to that branch. The deployment process is handled by the `.circleci/config.yml` file.

Once the Circle CI process is completed, the site will be deployed to the VIP Go environment by a process on that environment.

Deployment process can be followed on the Circle CI dashboard as well as the WordPress VIP Dashboard.
