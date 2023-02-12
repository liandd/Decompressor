# decompressor
A small script in bash to decompress a file that has a unknown amount of compressed files inside of it for bandit14,
the script it's usefull because you do not have to be looking one by one the files.
Once you decompressed content.gzip there is no need to know if the new file it's compressed again and do the same repetitive process.


![image](https://user-images.githubusercontent.com/114973749/218240673-abb63172-cdf3-430c-bb9b-322764a4e52e.png)

Decompressor will check the last argument of the file using 7z and if it is a compressed file it will check again and again until there is no need. 


https://user-images.githubusercontent.com/114973749/218285322-b1da8470-b1fd-4a3e-818e-104c0e05f3c9.mp4


Decompressor know the last final can not be decompressed so it applies a /bin/cat to the file and we have the content much faster than going one by one

https://user-images.githubusercontent.com/114973749/218289789-34ce68bd-a324-4ce7-b40f-e8279f2d7832.mp4

