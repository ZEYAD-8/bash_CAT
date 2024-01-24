#!/bin/bash

password_generator() {
    length=$1
    complexity=$2
    password=""

    digits="0123456789"
    lower="abcdefghijklmnopqrstuvwxyz"
    upper="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    special_chars="!@#$%^&*()_-+=<>?/{}[]"

    for ((i = 1; i <= length; i++)); do
        if [ $i -gt $complexity ]; then
            random_set=${complexity:RANDOM % $complexity}
        else
            random_set=$i
        fi

        case $random_set in
            "1") random_char=${digits:RANDOM % 10:1} ;;
            "2") random_char=${lower:RANDOM % 26:1} ;;
            "3") random_char=${upper:RANDOM % 26:1} ;;
            "4") random_char=${special_chars:RANDOM % ${#special_chars} :1} ;;
              *) random_char=${digits:RANDOM % 10:1} ;;
        esac
        password="$password$random_char"
        
    done

    echo "$password"
}

Invalid_length=true

while $Invalid_length; do
    read -p "Enter the length of the password: " password_length
    password_length=${password_length:-"-1"}

    if [ $password_length -gt 3 ]; then
        Invalid_length=false
    else
        echo "** Invalid length, should be a number greater than 3. try again."
    fi
done

read -p "******************
Enter the complexity (1-4, default is 4):
1: Only Digits
2: Digits and Lower case letters
3: Digits & Upper and Lower case letters
4: Digits & Upper and Lower case letters & special characters
Complexity: " password_complexity

if ! [[ $password_complexity =~ ^[1-4]$ ]]; then
    echo "** Invalid complexity. Using default (4)."
    password_complexity=4
fi

password=$(password_generator $password_length $password_complexity)
echo "******************
Generated Password: $password"
