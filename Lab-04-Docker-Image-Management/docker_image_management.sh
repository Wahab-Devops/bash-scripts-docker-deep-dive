#!/bin/bash

#!/bin/bash

# Task 1: List all Docker images
echo "Listing all Docker images:"
docker images

# Task 2: Har image ke liye alag permission lo
docker images --format "{{.ID}} {{.Repository}}:{{.Tag}}" | while read -r image_id image_name; do
echo ""
echo "Image: $image_name (ID: $image_id)"
read -p "Kya yeh image remove karni hai? (yes/no): " confirmation </dev/tty
if [ "$confirmation" == "yes" ]; then
echo "Removing $image_name ..."
docker rmi "$image_id"
else
echo "Skipped $image_name"
fi
done
echo ""
echo "Done."
