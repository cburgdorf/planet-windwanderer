#!/bin/bash

# The planet.toml file
TOML_FILE="planet.toml"
# Output file
OUTPUT_FILE="./templates/search.html"

# Start the HTML file without a newline
echo -n '<script async src="https://cse.google.com/cse.js?cx=6476aef88fae44805"></script><div class="gcse-search" data-as_oq="' > "$OUTPUT_FILE"

# Extract all lines with 'sitemap' and retrieve the domain
first=true
grep 'sitemap' "$TOML_FILE" | while read -r line; do
    # Extract the domain from the sitemap URL (everything after "://", up to the first "/")
    domain=$(echo "$line" | sed -E 's/.*sitemap\s*=\s*".*:\/\/([^\/]+).*/\1/')

    # Add "site:" before the domain
    site="site:$domain"
  
    # If it's not the first line, add a space
    if [ "$first" = true ]; then
        first=false
    else
        echo -n " " >> "$OUTPUT_FILE"
    fi

    # Add the site:domain to the output
    echo -n "$site" >> "$OUTPUT_FILE"
done

# Close the HTML structure
echo '"></div>' >> "$OUTPUT_FILE"

# Finished
echo "The file $OUTPUT_FILE has been successfully generated!"
