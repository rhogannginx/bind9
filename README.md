# bind9
Code repository for generating a Docker image of a reliable DNS (BIND9) server with sample configuration files for use casses such as local off-line network zones for demonstration and other purposes.

Steps to use:

1.  Clone this repository
2.  Change to the new "bind9" directory that was cloned
3.  Edit the zone files to use names of your choosing
3.  From the command prompt, enter
    $ docker build -t bind .
4.  Now run the
