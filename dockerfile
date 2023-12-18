FROM python:3.6-slim
COPY . /python-test-calculator
WORKDIR /python-test-calculator
RUN pip install --no-cache-dir 
RUN ["pytest", "-v", "--junitxml=reports/result.xml"]
CMD tail -f /dev/null