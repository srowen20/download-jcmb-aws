#!/bin/bash

# Default parameters
days_prior=1
url_format="https://www.geos.ed.ac.uk/dev/weatherstation/download/%Y-%m-%d_minute_data.csv"
output_dir="."

# Parse command line arguments
while getopts "d:u:o:" opt; do
  case $opt in
    d) days_prior=$OPTARG ;;
    u) url_format=$OPTARG ;;
    o) output_dir=$OPTARG ;;
    *) echo "Usage: $0 [-d days_prior] [-u url_format] [-o output_dir]" >&2
       exit 1 ;;
  esac
done

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Loop over the specified number of days prior
for ((i=0; i<days_prior; i++)); do
  # Calculate the date for each iteration
  date=$(date -d "-$i days" +%Y-%m-%d)
  
  # Format the URL
  url=$(date -d "-$i days" +"$url_format")
  
  # Download the file to the specified directory
  wget "$url" -O "${output_dir}/${date}_minute_data.csv"
  
  echo "Downloaded: ${output_dir}/${date}_minute_data.csv"
done
