"""Test Parsing Script via Google CS course"""

import argparse

def main() -> None:
    """Script that will take in file and parse data"""
    # argparse helpers

    parser = argparse.ArgumentParser(description='Read this file.')
    parser.add_argument('f', type=str, help='Path to file' )

    all_args = parser.parse_args()
    f = all_args.f

    with open(f, 'r') as file:
        file_txt = file.read()

    failed_attempts = 0
    login_list = file_txt.split()

    for u in login_list:
        if u == '':
            counter += 1
        if counter > 3:
            return 'Account Locked due to 3 failed attempts to access'
        return 'You may attempt to log in again'

if __name__ == '__main__':
    main()
