FROM python:3.7.3-slim

RUN apt-get update && apt-get -y install cron 

# Copy hello-cron file to the cron.d directory
COPY dailyauto-cron /etc/cron.d/dailyauto
COPY dailyauto.sh /dailyauto.sh
COPY dailyauto.py /dailyauto.py

# COPY daily_creator.py /daily_creator.py

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/dailyauto \
    && crontab /etc/cron.d/dailyauto \
    && touch /daily.log

# Run the command on container startup
CMD cron -f