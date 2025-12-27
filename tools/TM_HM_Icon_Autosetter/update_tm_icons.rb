require 'json'

# Define paths relative to the script execution directory or absolute
# Assuming script is run from project root or placed in project root
ROOT_DIR = File.dirname(__FILE__)
ITEMS_DIR = File.join(ROOT_DIR, 'data/studio/items')
MOVES_DIR = File.join(ROOT_DIR, 'data/studio/moves')

# Verify directories exist
unless Dir.exist?(ITEMS_DIR) && Dir.exist?(MOVES_DIR)
  puts "Error: Could not find 'data/studio/items' or 'data/studio/moves' directories."
  puts "Please make sure you are running this script from the project root folder."
  exit 1
end

puts "Starting TM Icon Update..."

# Glob all tm*.json and hm*.json files
tm_files = Dir.glob(File.join(ITEMS_DIR, '{tm,hm}*.json'))

# Files to exclude
EXCLUDED_FILES = ['tmv_pass.json', 'tm_case.json']

count_updated = 0
count_skipped = 0
count_errors = 0

tm_files.each do |file_path|
  filename = File.basename(file_path)

  # Check exclusions
  if EXCLUDED_FILES.include?(filename)
    puts "Skipping excluded file: #{filename}"
    next
  end

  begin
    # Read the item file
    content = File.read(file_path)
    item_data = JSON.parse(content)

    # Get the move identifier
    move_id = item_data['move']

    unless move_id
      puts "Skipping #{filename}: No 'move' field defined."
      count_skipped += 1
      next
    end

    # Find the corresponding move file
    # The move ID in item file corresponds to the filename in moves directory
    move_file_path = File.join(MOVES_DIR, "#{move_id}.json")

    unless File.exist?(move_file_path)
      puts "Warning: Move file '#{move_id}.json' not found for item #{filename}"
      count_errors += 1
      next
    end

    # Read the move file to get the type
    move_content = File.read(move_file_path)
    move_data = JSON.parse(move_content)
    
    type = move_data['type']
    
    unless type
      puts "Warning: No 'type' field found in move file for #{move_id}"
      count_errors += 1
      next
    end

    # Construct the new icon name
    new_icon = "#{type}TM"

    # Check if update is needed
    if item_data['icon'] != new_icon
      item_data['icon'] = new_icon
      
      # Write back to file with pretty formatting (2 space indent)
      # Using JSON.generate with options to match typical formatting
      File.write(file_path, JSON.pretty_generate(item_data))
      
      puts "Updated #{filename}: Set icon to '#{new_icon}' (Move: #{move_id}, Type: #{type})"
      count_updated += 1
    else
      # puts "No change needed for #{filename}" # Uncomment for verbose output
      count_skipped += 1
    end

  rescue JSON::ParserError => e
    puts "Error parsing JSON in file #{filename}: #{e.message}"
    count_errors += 1
  rescue => e
    puts "An unexpected error occurred processing #{filename}: #{e.message}"
    count_errors += 1
  end
end

puts "\n--------------------------------------------------"
puts "Process Complete."
puts "Updated: #{count_updated} files"
puts "Skipped/Unchanged: #{count_skipped} files"
puts "Errors: #{count_errors} files"
