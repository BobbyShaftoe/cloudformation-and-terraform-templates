#!/usr/bin/env python

# Run this script in the root directory
# USAGE:  ./enumerate_tf_rs.py 'search_string'
#  or with no args  ./enumerate_tf_rs.py
# 'search_string' will match the terraform resource type
#  eg. aws_instance or aws_elb

import sys
import os
import re

dir_list = []
file_catalogue = []
resource_catalogue =[]

try:
    rtype = sys.argv[1]
except IndexError:
    rtype = ''

path = os.getcwd()

for root, dirs, files in os.walk(path, topdown=True):
    for i, name in enumerate(files):
        path_pattern = re.compile(path + '/')
        short_path = re.sub(path_pattern, '', root)
        path_array = short_path.split(os.sep)

        m = re.match(r'.*\.tf$', name)
        if m:
            fullpath = str(short_path) + '/' + str(name)
            file_catalogue.append([fullpath, path_array])

for file, path in file_catalogue:
    with open(file, 'r') as f:
        for line in f:
            m = re.match(r'^\s*(resource)\s*"([\w]+)"\s*"([\w]+)"', line)
            if m:
                is_resource = 1
                resource_catalogue.append([file, m.group(2), m.group(3)])
                print file + ', ' + m.group(2) + ', ' + m.group(3)

filename = 'resource_catalogue.csv'
with open(filename, 'w+') as f:
    f.write('Path, Resource, Name\n')
    for row in resource_catalogue:
        f.write(row[0] + ', ' + row[1] + ', ' + row[2] + ', ' + '\n')

print ("\n------------------------------------------------------------------\n\n" )


def column(matrix, i):
    return [row[i] for row in matrix]

file_list = sorted(set(column(resource_catalogue, 0)))
resource_types = sorted(set(column(resource_catalogue, 1)))
resource_labels = sorted(set(column(resource_catalogue, 2)))

print ("\n".join(file_list))
print ("\n------------------------------------------------------------------\n" )

print ("\n".join(resource_types))
print ("\n------------------------------------------------------------------\n" )

print ("\n".join(resource_labels))
print ("\n------------------------------------------------------------------\n" )



print rtype
rtype_pattern = re.compile('.*' + rtype + '.*')

selected_file = ''

for item in resource_catalogue:
    file = item[0]
    m = rtype_pattern.match(item[1])
    if m or rtype == '':

        if selected_file != file:
            print '\n' + file

            selected_resource = ''

            for row in resource_catalogue:
                resource = row[1]
                if row[0] == file:

                    if selected_resource != resource:
                        print '\n  ' + row[1] + ': '
                    print '\t\t\t' + row[2]
                    selected_resource = resource
        selected_file = file


print ("\n\n")







