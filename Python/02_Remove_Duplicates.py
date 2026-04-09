"""
===============================================================================
Python Script: Remove Duplicate Characters
===============================================================================
Script Purpose:
    This script takes a string input and removes duplicate characters
    using a loop, preserving the original order.

    Example:
        "aabbcc" -> "abc"
        "programming" -> "progamin"

    It demonstrates string manipulation and loop logic.

===============================================================================
WARNING:
    - Input is case-sensitive
    - Works only for string input
===============================================================================
"""  
# CODE FOR Remove Duplicate Characters
def remove_duplicates(text):
    result = ""

    for char in text:
        if char not in result:
            result += char

    return result


# input
text = input("Enter a string: ")

# output
print(remove_duplicates(text))
