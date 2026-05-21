"""
Usage: python3 main.py <input_file> <word>
"""

import sys
import re


def main():
    if len(sys.argv) != 3:
        print("Usage: python3 main.py <input_file> <word>")
        sys.exit(1)

    input_file = sys.argv[1]
    search_word = sys.argv[2].lower()   # caseless comparison

    try:
        with open(input_file, "r", encoding="ascii") as fh:
            lines = fh.readlines()
    except FileNotFoundError:
        print(f"Error: file '{input_file}' not found.")
        sys.exit(1)
    except OSError as exc:
        print(f"Error reading file: {exc}")
        sys.exit(1)

    #g1 = student number (one or more digit) -> (/d+)
    #g2 everything after ',' -> (.+)
    # blank or illegal are skipped
    # SOL = ^
    # comma followed by char = ,\s+
    # comma not captured ,
    # $ = EOL
    pattern = re.compile(r"^(\d+),\s+(.+)$")

    matching_numbers = []

    for line in lines:
        line = line.strip()
        if not line:            # skip blank lines
            continue

        match = pattern.match(line)
        if not match:           # skip malformed lines
            continue

        student_number = int(match.group(1))
        full_name      = match.group(2).strip()

        # The last name is the final whitespace-delimited token
        last_name = full_name.split()[-1].lower()

        if last_name > search_word:
            matching_numbers.append(student_number)

    if not matching_numbers:
        print("None found")
    else:
        for number in sorted(matching_numbers):   # numeric (integer) order
            print(number)


if __name__ == "__main__":
    main()
