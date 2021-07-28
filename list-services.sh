#!/bin/bash
USER=$(aws sts get-caller-identity | jq -r '.["Arn"]')
aws configservice put-configuration-recorder --configuration-recorder name=default,roleARN=$USER --recording-group allSupported=true,includeGlobalResourceTypes=true
while read line; do
    aws configservice list-discovered-resources --resource-type $line
done < ./resources
