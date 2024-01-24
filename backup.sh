#!/bin/bash

path_to_backup="/Desktop"
backup_filename="home_backup.tar.gz"

tar -cfz "$path_to_backup/$backup_filename" /home
