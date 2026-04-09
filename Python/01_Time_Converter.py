"""
===============================================================================
Python Script: Time Converter
===============================================================================
Script Purpose:
    This script converts a given number of minutes into a human-readable
    format (hours and minutes).

    Example:
        130 -> 2 hrs 10 minutes
        110 -> 1 hr 50 minutes

    It uses basic arithmetic operations and user input.

===============================================================================
WARNING:
    - Input should be a valid integer
    - Negative values may give incorrect results
===============================================================================
"""  
## PYTHON CODE  FOR TIME CONVERTER

minutes = int(input("Enter minutes: "))

hours = minutes // 60
mins = minutes % 60

print(hours, "hrs", mins, "minutes")
