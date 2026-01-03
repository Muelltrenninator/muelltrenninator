FROM dart:stable AS build

WORKDIR /app
COPY . .
RUN sed -i "s/- packages\/muelltrenninator_client/# - packages\/muelltrenninator_client/" pubspec.yaml

WORKDIR /app/packages/muelltrenninator_server
RUN dart pub get
RUN dart compile exe bin/server.dart -o bin/server

FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/packages/muelltrenninator_server/bin/legal/ /app/bin/legal/
COPY --from=build /app/packages/muelltrenninator_server/bin/public/ /app/bin/public/
COPY --from=build /app/packages/muelltrenninator_server/bin/server /app/bin/

EXPOSE 33553
CMD ["/app/bin/server"]
