import os

unique = set()
for root, subFolders, files in os.walk('.'):
	for fileName in files:
		if '.java' in fileName:
			f = open(os.path.join(root,fileName),'r')
			for line in f:
		   	    if 'import' in line:
		   	        if 'import java.' not in line and 'import android' not in line:
			    		unique.add(line)
			f.close()

for item in unique:
	print item