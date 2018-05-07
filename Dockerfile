FROM civisanalytics/datascience-r:2.3.0

RUN apt-get update && apt-get install -y \
    git

COPY ./requirements.txt /requirements.txt
RUN Rscript -e "packages <- readLines('/requirements.txt'); install.packages(packages)"
RUN Rscript -e "devtools::install_github('tidyverse/tidyverse')"
COPY ./app/app.r ./app/app.r
COPY entrypoint.sh /

EXPOSE 3838

ENTRYPOINT ["/entrypoint.sh"]
