import itertools

def generate_email_variations(email):
    local_part, domain = email.split('@')
    indices = range(len(local_part) - 1)
    variations = set()

    for i in range(1, len(local_part)):
        for combination in itertools.combinations(indices, i):
            new_email = list(local_part)
            for index in combination:
                new_email[index] = new_email[index] + '.'
            variations.add(''.join(new_email) + '@' + domain)
    
    return variations

def save_variations_to_file(email, filename="email_variations.txt"):
    variations = generate_email_variations(email)
    with open(filename, 'w') as file:
        for variation in variations:
            file.write(variation + '\n')

if __name__ == "__main__":
    email = input("Enter your email: ")
    save_variations_to_file(email)
    print(f"All possible variations have been saved to email_variations.txt")
