# Using Official Python runtime as a parent image
FROM python:3.10.12
# Set the working directory in the container
WORKDIR /app
# Copy the files into the directory in the container 
COPY . /app
#Update pip to latest version
RUN pip install --upgrade pip
# Install any needed packages for the application to run 
RUN pip install pipenv --default-timeout=100 --retries=5
# Copy the `Pipfile` and `Pipfile.lock` into the container at `/app`
COPY Pipfile Pipfile.lock /app/
# Install dependencies 
RUN pipenv install --system --deploy --ignore-pipfile
# Expose  the port the app runs on 
EXPOSE 8000
# Run the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
