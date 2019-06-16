import os

def convert_to_pig(file_path):
	'''
	   takes file path as input and convert into pig latin 
	   and store into pig_latin folder with same file name
	'''
	original = open(file_path, "r").read()
	print('converting '+ file_path + ' ..............')
	words = original.split()
	for word in words:
	    if len(original) > 0 :
	        first = word[0]
	        extra_word = ''
	        if not 64 < ord(word[-1]) < 123:
	            extra_word = word[-1]
	            word = word[:-1]
	        if first in 'aeiouAEIOU':
	            new_word = word + 'yay' + extra_word
	        else:
	            if first == first.upper():
	                new_word = str(word[1:] + first + 'ay' + extra_word ).title()
	            else:
	                new_word = word[1:]+ first + 'ay' + extra_word
	        open('pig_latin/'+file_path, "a+").write(new_word+' ')
	    else:
	        print ('empty file...')

if  __name__ == "__main__":
    ''' listing current directory for getting text.. '''
    files = os.listdir()
    try:
       os.mkdir('pig_latin')
    except:
       pass
    for file in files:
         if file.endswith('.txt'):     
               convert_to_pig(file)
