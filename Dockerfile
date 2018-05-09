FROM civisanalytics/datascience-r:2.3.0

RUN apt-get update && apt-get install -y \
    git

COPY ./requirements.txt /requirements.txt
RUN Rscript -e "packages <- readLines('/requirements.txt'); install.packages(packages)"
RUN Rscript -e "devtools::install_github('tidyverse/tidyr')"
RUN Rscript -e "devtools::install_github('tidyverse/forcats')"
# Install emojis
RUN Rscript -e "devtools::install_github('hadley/emo')"

# DT requires >= v.1 of html widgets. Install latest commit fromt html widgets
RUN Rscript - e "devtools::install_github('ramnathv/htmlwidgets', ref = '2919c0162283eb1015f875ec25a705c57444f764')"
RUN Rscript -e "devtools::install_github('rstudio/DT', ref = 'v0.4')"

COPY ./app/app.r ./app/app.r
COPY entrypoint.sh /

EXPOSE 3838

ENTRYPOINT ["/entrypoint.sh"]
