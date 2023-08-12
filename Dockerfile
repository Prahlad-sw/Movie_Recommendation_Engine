#FROM python:3.9-slim
#WORKDIR /app
#COPY . /app
#RUN pip install -r requirements.txt
#EXPOSE 8501
#
#HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health
#
#ENTRYPOINT ["streamlit", "run", "streamlit_app.py", "--server.port=8501", "--server.address=0.0.0.0"]
#



# FROM python:3.9-slim

# WORKDIR /app
# COPY . /app

# # Install necessary dependencies for curl
# RUN apt-get update && apt-get install -y curl

# # Install Python dependencies
# RUN pip install -r requirements.txt

# # Expose port 8501
# EXPOSE 8501

# # Add a health check command using curl to verify the app's health
# HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health || exit 1

# # Run the Streamlit app
# CMD ["streamlit", "run", "streamlit_app.py", "--server.port=8501", "--server.address=0.0.0.0"]
#FROM python:3.9-slim
#WORK /app
#DIRCOPY . /app
#RUN pip install -r requirements.txt
#EXPOSE 8501
#
#HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health
#
#ENTRYPOINT ["streamlit", "run", "streamlit_app.py", "--server.port=8501", "--server.address=0.0.0.0"]
#



FROM python:3.9-slim

WORKDIR /app
COPY . /app

# Install necessary dependencies for curl
RUN apt-get update && apt-get install -y curl

# Install necessary dependencies for protobuf
RUN-get install apt -y build-essential autoconf libtool pkg-config

# Install the latest protobuf from PyPI
RUN pip install --no-binary protobuf protobuf

# Install Python dependencies
RUN pip install -r requirements.txt

# Expose port 8501
EXPOSE 8501

# Add a health check command using curl to verify the app's health
HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health || exit 1

ENTRYPOINT ["streamlit", "run", "streamlit_app.py", "--server.port=8501", "--server.address=0.0.0.0"]

