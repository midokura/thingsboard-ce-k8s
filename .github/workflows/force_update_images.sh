#!/bin/bash

set -e

evp_mqtt_image="${1:-$EVP_MQTT_IMAGE}"
git_branch="helmrepo"

if [[ -z "$evp_mqtt_image" ]]
then
  echo "the evp_mqtt_image must not be empty"
  exit 1
fi

set -x

echo Git branch: "$git_branch"

values_file=helm/thingsboard/values.yaml
chart_file=helm/thingsboard/Chart.yaml

if [[ "$evp_mqtt_image" ]]
then
  yq -i e '.mqtt.evpImage="'"$evp_mqtt_image"'"' "$values_file"
fi

current_version=$(yq '.version' $chart_file)

# Extract base and last number using regex
base="${current_version%.*}"
last="${current_version##*.}"

# Increment the last number
((last++))

# Combine again
new_version="${base}.${last}"

echo "$new_version"

#Update the version in the chart
yq -i e '.version="'"$new_version"'"' "$chart_file"

git commit -a -m "bump evp-mqtt image to $evp_mqtt_image and release chart to $new_version"
git push --set-upstream origin "$git_branch"
