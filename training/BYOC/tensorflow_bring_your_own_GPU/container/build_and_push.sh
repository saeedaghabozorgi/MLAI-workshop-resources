%%sh

# The name of our algorithm
algorithm_name=sagemaker-tf-cifar10-example-gpu

cd container

chmod +x cifar10/train.py
chmod +x cifar10/serve

account=$(aws sts get-caller-identity --query Account --output text)

# Get the region defined in the current configuration (default to us-west-2 if none defined)
region=$(aws configure get region)
echo $region
region=${region:-us-east-1}

fullname="${account}.dkr.ecr.${region}.amazonaws.com/${algorithm_name}:latest"
echo $fullname
# If the repository doesn't exist in ECR, create it.

aws ecr describe-repositories --repository-names "${algorithm_name}" > /dev/null 2>&1

if [ $? -ne 0 ]
then
    aws ecr create-repository --repository-name "${algorithm_name}" > /dev/null
fi



# Get the login command from ECR and execute it directly
$(aws ecr get-login --region ${region} --no-include-email)

echo $(aws ecr get-login --region ${region} --no-include-email)
# Build the docker image locally with the image name and then push it to ECR
# with the full name.

docker build  -t ${algorithm_name} .
docker tag ${algorithm_name} ${fullname}

#docker push ${fullname}