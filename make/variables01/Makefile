files := file1 file2
some_file: $(files)
	echo $?
	echo "Look at this variable: " $(files)
	touch some_file

file1:
	echo $@
	touch file1
file2:
	echo $@
	touch file2

clean:
	rm -f file1 file2 some_file
