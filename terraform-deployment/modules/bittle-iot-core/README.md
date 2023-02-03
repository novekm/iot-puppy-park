## .ino files/related .h files are dynamically created for each bittle you
## specify in main.tf. Upon successful 'terraform apply' a folder labeled
'ESP8266_AWS_IOT' will be created with sub folders for each Bittle. In each
sub folder will be the .ino and .h files. Use these to update the sketch on
each Bittle. To make global changes to all of the .ino and .h files, edit
the code in 'localfile.tf'
