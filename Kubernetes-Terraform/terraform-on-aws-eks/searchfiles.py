import os
import re

path = '.'  # replace with the root directory you want to search in
count = 0   # initialize the count of replacements

replacement_table_name = "tflockDDB-mtekdevops-dev"

for root, dirs, files in os.walk(path):
    for file in files:
        if file.endswith('.tf'):
            filepath = os.path.join(root, file)
            with open(filepath, 'r') as f:
                lines = f.readlines()

            modified_lines = []
            tablename = None  # initialize tablename as None
            for line in lines:
                if 'dynamodb_table =' in line:
                    match = re.search(r'"([^"]*)"', line)
                    if match:
                        tablename = match.group(1)
                        print(f"Found tablename {tablename} in file {filepath}")
                        line = line.replace(tablename, replacement_table_name)
                        count += 1   # increment the count of replacements
                modified_lines.append(line)

            if tablename is not None:  # if a replacement was made
                with open(filepath, 'w') as f:
                    f.writelines(modified_lines)
                print(f"Replaced tablename {tablename} with {replacement_table_name} in file {filepath}")

print(f"Number of replacements: {count}")
