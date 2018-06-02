#Lets use ubuntu
FROM ubuntu:16.04


#CREATE A WORKING DIRECTORY
WORKDIR /devstack

#ADD Shell bin
ADD ./clouduser.sh ./clouduser.sh

#Run shell to create user and switch to user
RUN ./clouduser.sh


RUN /bin/su - stack
#ADD all FILES
ADD ./devstack . 
ADD ./local.conf /devstack



#Expose the port 80
EXPOSE 80


#Change WORDIR
#WORKDIR /devstack

#Default command
#CMD ["/sbin/runuser -l stack -c ./stack.sh"]

