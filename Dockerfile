FROM rocker/verse
COPY . /usr/local/src/myscripts
WORKDIR /usr/local/src/myscripts
RUN R -e "devtools::install_github('r-dbi/bigrquery')"
RUN R -e "install.packages('config')"
RUN R -e "install.packages('glue')"
CMD ["Rscript", "test.R"]
