#!/usr/bin/env python 

import boto3
import re

instances = []

def lambda_handler(event, context):
        ec2client = boto3.client('ec2')

        instance_states = [ 'stopped', 'running' ]

        for state in instance_states:
            print ("\n" + "INSTANCES IN STATE: " + state + "\n\n")

            response = ec2client.describe_instances(

                Filters=[{'Name': 'instance-state-name', 'Values': [state]}]

            )

            for reservation in response["Reservations"]:
                    for instance in reservation["Instances"]:

                        print( instance["InstanceId"] + instance["ImageId"]
                                      + ", " + instance["InstanceType"] + ", " + instance["Placement"]["AvailabilityZone"]
                                      + ", " + instance["StateTransitionReason"]
                                      + ", " + instance["SecurityGroups"][0]["GroupName"] + "\n")

                    type = instance["InstanceType"]
                    id = instance["InstanceId"]
                    match_small = re.search(".*?\.(small|micro)$", type)
                    if (state == 'running') and not match_small:
                        print 'need to stop this: ' + id
                        instances.append(instance)


        ec2.stop_instances(InstanceIds=instances)
        print 'stopped your instances: ' + str(instances)
