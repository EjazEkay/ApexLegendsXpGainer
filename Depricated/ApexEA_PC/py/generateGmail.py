import itertools

def generate_gmail_variations(email):
    local, domain = email.split('@')
    name, domain_ext = domain.split('.')

    variations = set()
    
    # Generate all dot variations within the local part
    dot_positions = list(itertools.product(['', '.'], repeat=len(local)-1))
    
    for positions in dot_positions:
        new_local = local[0]
        for pos, char in zip(positions, local[1:]):
            new_local += pos + char
        variations.add(f"{new_local}@{domain}")
        variations.add(f"{new_local}@{name}.{domain_ext}")

    return list(variations)

def save_variations_to_file(variations, filename):
    with open(filename, 'w') as file:
        for variation in variations:
            file.write(variation + '\n')

email = 'ihsansultan0123@gmail.com'
variations = generate_gmail_variations(email)
save_variations_to_file(variations, '.././data/gmail_variations.txt')

print(f"Generated {len(variations)} variations and saved to gmail_variations.txt")
