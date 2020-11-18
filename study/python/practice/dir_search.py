import sys
import os

def search(path):
    filenames = os.listdir(path)
    for filename in filenames:
        full_filename = os.path.join(path, filename)

        if os.path.isdir(full_filename):
            search(full_filename)
        else:
            ext = os.path.splitext(full_filename)[-1]        
            
            if ext == '.py':
                print(full_filename)


arg_path = sys.argv[1]

search(arg_path)