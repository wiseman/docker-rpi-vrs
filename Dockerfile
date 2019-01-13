FROM arm32v7/mono

WORKDIR /app/vrs

COPY build/vrs /app/vrs
COPY vrs-runner.sh /app/vrs
RUN mkdir -p /var/vrs

EXPOSE 8080

CMD sh vrs-runner.sh
