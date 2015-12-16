import os
import operator

original  = set()
duplicate = set()
permissionList = {}
previousDirectory = os.getcwd()

for root, subFolders, files in os.walk('.'):
	for currentDirectory in subFolders:
		path = previousDirectory+'/'+currentDirectory+'/'
		os.chdir(path)
		#print os.getcwd()
		
		f = open('ori.txt','r')
		for line in f:
		   	if 'android:name' in line:
		   		pos = line.index('android:name')
		   		permission = line[pos:]
		   		finalPermission = permission.split('"')		   		
				original.add(finalPermission[1].rsplit('.')[-1])
		f.close()

		f = open('dup.txt','r')
		for line in f:
		   	if 'android:name' in line:
		   		pos = line.index('android:name')
		   		permission = line[pos:]
		   		finalPermission = permission.split('"')
		   		duplicate.add(finalPermission[1].rsplit('.')[-1])
		f.close()

		extraPermission = duplicate.difference(original)
		
		for perm in extraPermission:
			count = 1
			if perm in permissionList:
				count = permissionList[perm] + 1
			permissionList[perm] = count

		original  = set()
		duplicate = set()
		os.chdir(previousDirectory)

permissionList = sorted(permissionList.items(), key=operator.itemgetter(1), reverse = True)
for key,value in permissionList:
	print key, value