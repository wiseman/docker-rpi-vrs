FROM arm32v7/mono

WORKDIR /app/vrs

COPY vrsbuild /app/vrs
COPY vrs-runner.sh /app/vrs

EXPOSE 8080

CMD sh vrs-runner.sh
