#!/bin/bash

# Check if the number of arguments is correct
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# Get the target directory path from the first argument
target_directory="$1"

# Check if the target directory exists
if [ ! -d "$target_directory" ]; then
  echo "Error: Directory '$target_directory' does not exist."
  exit 1
fi

# Store the current directory in a variable
current_directory=$(pwd)

# Change to the target directory
cd "$target_directory" || exit 1

# Get the current Git branch name
branch_name=$(git rev-parse --abbrev-ref HEAD)

# Get the current date in the format YYYY-MM-DD
current_date=$(date +%Y-%m-%d)

# Content to be written to the file with the current date and branch name
content="#ifndef COMPONENTS_HOMETHING_VERSION_H_
#define COMPONENTS_HOMETHING_VERSION_H_
#include <string>

namespace esphome {
namespace homething_menu_base {
static const std::string COMPONENTS_HOMETHING_VERSION = \"${branch_name}/${current_date}\";
}
}  // namespace esphome
#endif  // COMPONENTS_HOMETHING_VERSION_H_
"

# Generate the output file path with the desired name
output_file="components/homeThing/version.h"

# Write the content to the file in the target directory
echo "$content" > "$output_file"

echo "Content has been written to $target_directory/$output_file."

# Go back to the previous directory
cd "$current_directory"