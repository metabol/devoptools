#Slect python 2.7-slim
FROM python:2.7-slim



#Change to /app directory
WORKDIR /app

#Copy contents to /app
ADD . /app

#Download python app requirements
RUN pip install --trusted-host pypi.python.org -r req.txt

#Expose port 80
EXPOSE 80

#Define Environmental Variables
ENV NAME PyApp

#Command to run after creating container
CMD ["python","app.py"]
