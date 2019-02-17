REGION=us-east-2
aws elbv2 describe-load-balancers  --region $REGION > elbs.json
ELBARN=$(aws elbv2 describe-load-balancers  --region $REGION | jq -r '.LoadBalancers[0] .LoadBalancerArn')
aws ec2 describe-instances  --region $REGION > instances.json
aws elbv2 describe-listeners --load-balancer-arn $ELBARN  --region $REGION > listeners.json
aws ec2 describe-nat-gateways  --region $REGION > nats.json
aws ec2 describe-route-tables  --region $REGION > routes.json
aws ec2 describe-subnets  --region $REGION > subnets.json
aws elbv2 describe-target-groups  --region $REGION > targetgroups.json
TGARN=$(aws elbv2 describe-target-groups  --region $REGION | jq -r '.TargetGroups[0] .TargetGroupArn')
aws elbv2 describe-target-health --target-group-arn $TGARN  --region $REGION > targethealth.json
aws ec2 describe-security-groups  --region $REGION > security-groups.json
aws ec2 describe-vpcs  --region $REGION > vpcs.json
