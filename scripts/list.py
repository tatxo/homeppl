import sys
import boto3

def main():
    if len(sys.argv) < 2:
        print("Please supply a VPC id as an argument!")
    else:
        vpc_id = sys.argv[1]
        print("VPC ID:", vpc_id)

        ec2 = boto3.resource('ec2')

        # Get VPC resource using Ec2 resource by supplying VPC ID
        vpc = ec2.Vpc(vpc_id)
        print("VPC CIDR:", vpc.cidr_block)

        # Get subnets
        subnets = list(vpc.subnets.all())
        if len(subnets) > 0:
            print("\nSubnets:")
            for subnet in subnets:
                print(subnet.id, "-", subnet.cidr_block)
        else:
            print("There is no subnet in this VPC")

        # Get ec2 instances
        ec2client = boto3.client('ec2')
        ec2_instances = ec2client.describe_instances()
        if len(ec2_instances) > 0:
            print("\nInstances:")
            for reservation in ec2_instances["Reservations"]:
                for instance in reservation["Instances"]:
                    print(instance["InstanceId"], "-", instance["InstanceType"], "-", instance["PrivateDnsName"])
        else: 
            print("There is no EC2 instances in this VPC")

        # Get Internet Gateways
        ec2_igw = ec2client.describe_internet_gateways()
        if len(ec2_igw) > 0:
            print("\nInternet Gateways:")
            for gateway in ec2_igw["InternetGateways"]:
                print(gateway["InternetGatewayId"])

        # Get Route Tables 
        ec2_rt = ec2client.describe_route_tables()
        if len(ec2_igw) > 0:
            print("\nRoute Tables:")
            for rt in ec2_rt["RouteTables"]:
                print(rt["RouteTableId"],":")
                for route in rt["Routes"]: 
                    print("  ",route["GatewayId"], "-", route["DestinationCidrBlock"])

if __name__ == "__main__":
    main()
