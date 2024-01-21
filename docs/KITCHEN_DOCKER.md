## Run Kitchen-Terraform on docker

> ## !!!!! CAUTION !!!!!
> ***DO NOT PUSH IMAGE TO CLOUD*** \
> ***This Dockerfile contain multiple authentication information.*** \
> ***This Dockerfile only for personal dev environment***

### How To Use

you can skip this part if you already install kitchen-terraform on local machine

### Command List
- Build
  ```
  docker build \
    --build-arg GIT_USERNAME=your_username \
    --build-arg GIT_PAT=your_personal_access_token \
    --build-arg AWS_DEFAULT_PROFILE=aws_profile_for_kitchen \
    -t kitchen .
  ```

- Run
  ```
  docker run -it -v $(pwd):/usr/app -v ~/.aws:/root/.aws kitchen
  ```
