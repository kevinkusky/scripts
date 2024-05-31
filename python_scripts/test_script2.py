"""Second Test Script from Google Cyber Security Course"""

import argparse

def main() -> None:
    """
    Script based on the following prompt:
    
    You are a security professional working at a health care company. As part of your job, 
    you're required to regularly update a file that identifies the employees who can access restricted content. 
    The contents of the file are based on who is working with personal patient records. Employees are restricted access based on their IP address. 
    There is an allow list for IP addresses permitted to sign into the restricted subnetwork. 
    There's also a remove list that identifies which employees you must remove from this allow list.

    Your task is to create an algorithm that uses Python code to check whether the allow list contains any IP addresses identified on the remove list. 
    If so, you should remove those IP addresses from the file containing the allow list.
    """

    # argparse helpers
    # Infering this as a command ran script rather than a called method
    parser = argparse.ArgumentParser(description='Read this file.')
    parser.add_argument('given_file', type=str, help='Path to file' )
    parser.add_argument('remove_list', type=str, help='Comma-seperated list of IP addresses' )

    all_args = parser.parse_args()
    given_file = all_args.given_file
    remove_list = all_args.remove_list.split(',')

    # example remove_list
    # remove_list = ["192.168.97.225", "192.168.158.170", "192.168.201.40", "192.168.58.57"]

    # Save file contents
    with open(given_file, 'r', encoding='utf-8') as file:
        f_txt = file.read()

    # List comprehension to build new list of only approved IP Adresses
    # While the lab instructed practice with for loops and utilizing remove() for this task
    # Wanted to be more 'pythonic' in my solution
    ip_addresses = f_txt.split()
    ip_addresses = [addy for addy in ip_addresses if addy not in remove_list]

    updated_txt = ' '.join(ip_addresses)

    # Write to file with updates
    with open(given_file, 'w', encoding='utf-8') as file:
        file.write(updated_txt)

if __name__ == '__main__':
    main()
