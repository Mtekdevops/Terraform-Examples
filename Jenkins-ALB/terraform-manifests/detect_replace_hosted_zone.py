import boto3

#script for replacing the dns hosted zone with the one in AWS when using Acloud Guru 3h playgrounds (they change every time)
#since there is no terraform data source / other way to detect the one you want.  

# Create an Route53 client
client = boto3.client('route53')

desired_zone_name_partial = "cmcloudlab"
file_to_replace = "c6-02-datasource-route53-zone.tf"

# Call the list_hosted_zones method to get a list of hosted zones
response = client.list_hosted_zones()

# Get the list of hosted zones from the response
hosted_zones = response['HostedZones']

# Initialize a variable to store the hosted zone name
hosted_zone_name = None

# Iterate over the list of hosted zones
for hosted_zone in hosted_zones:
    # Check if the hosted zone name contains cmcloudlab
    if desired_zone_name_partial in hosted_zone["Name"]:
        # Write the hosted zone name to the variable
        hosted_zone_name = hosted_zone["Name"].rstrip(".")
        break

# Check if the hosted_zone_name variable is not None
if hosted_zone_name is not None:
# Open the file in read/write mode
    with open(file_to_replace, 'r+') as f:
    # Create a list of lines to be written to the file
        lines_to_write = []
        
        # Iterate over each line in the file
        for line in f:
            # If the line contains the string "cmcloud", replace it with the hosted zone name
            if "cmcloud" in line:
                line = f'  name         = "{hosted_zone_name}"\n'
                # Add the modified line to the list of lines to be written
            lines_to_write.append(line)
            
        # Seek to the beginning of the file
        f.seek(0)
        
        # Overwrite the file with the modified lines
        f.writelines(lines_to_write)
        
        # Truncate the file to the new length
        f.truncate()
else:
    print(f"NO HOSTED ZONES THAT MATCH {desired_zone_name_partial}  ")
    exit(1)

# # Print the hosted zone name
# hosted_zone_name = hosted_zone_name.rstrip(".")
# print(hosted_zone_name)