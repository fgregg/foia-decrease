library(RCurl)
library(xts)

foia_logs <- c(
    buildings='ucsz-xe6d',
    revenue='zrv6-shhf',
    three11='j2p9-gdf5',
    transportation='u9qt-tv7d',
    law='44bx-ncpi',
    aviation='jbth-h7cm',
    ethics='fhb6-wwuu',
    environment='s7ek-ru5b',
    police='wjkc-agnm', 
    fire='un3c-ixb7',
    oemc='8pxc-mzcv', 
    health='4h87-zdcp',
    compliance='pv55-neb6',
    #finance='7avf-ek45',
    procurement='bcyv-67qk',
    mayor='srzw-dcvg',
    water='cxfr-dd4a',
    streets='zpd8-zq4w',
    admin.hearing='t58s-ja5s',
    human.resources='7zkx-3pp7',
    budget='c323-fb2i',
    doit='4nng-j9hd',
    fleet='ten5-q8vs', 
    human.relations='52q7-yupi',
    special.events='kpzx-wx3r',
    clerk='72qm-3bwf',
    cultural='npw8-6cq9',
    comm.dev='rpya-q7ut',
    planning='5ztz-espx',
    animal='b989-387c',
    police.board='9pd8-s9t4',
    business.affairs='ybhx-inqb',
    ipra='gzxp-vdqf',
    family='yfhi-bd8g',
    license.commission='4nkr-n688',
    disability='fazv-a8mb',
    chicago.library='n379-5uzu',
    cultural='ikdf-ernx',
    treasurer='8gyi-fawp',
    zoning='2nra-kpzu',
    graphics='57s6-wkzs',
    fleet.facilities='nd4p-ckx9'
    )

date_received = c(
    police='date_recieved',
    oemc='received_date',
    fleet='date_requested')

full_log <- data.frame(year_month=NA)

for (i in 1:length(foia_logs)) {
    log_id <- foia_logs[i]
    log_name <- names(log_id)
    if (log_name %in% names(date_received)) {
        request_date <- date_received[log_name]
    }
    else {
        request_date <- 'date_received'
    }
    log_url <- paste(
        'https://data.cityofchicago.org/resource/',
        log_id,
        '.csv?$select=date_trunc_ym(',
        request_date,
        ')%20as%20year_month,COUNT(*)&$group=year_month&$order=year_month',
        sep='')
    log.csv <- RCurl::getURLContent(log_url)
    log <- read.csv(textConnection(log.csv))
    names(log) <- c("year_month", log_name)
    full_log <- merge(full_log, log, by="year_month", all=TRUE)
}


log_url <- paste(
    'https://data.cityofchicago.org/resource/',
    'ten5-q8vs',
    '.csv?$select=date_trunc_ym(',
    request_date,
    ')%20as%20year_month,COUNT(*)&$group=year_month&$order=year_month',
    sep='')
    log.csv <- RCurl::getURLContent(log_url)
    log <- read.csv(textConnection(log.csv))
    names(log) <- c("year_month", log_name)
    full_log <- merge(full_log, log, by="year_month", all=TRUE)


full_log$year_month <- as.Date(full_log$year_month, '%m/%d/%Y %I:%M:%S %p')

write.csv(full_log, file="foia_logs.csv", row.names=FALSE)

good_log <- full_log[full_log$year_month >= "2010-05-01" & full_log$year_month < "2015-05-01" & !is.na(full_log$year),]

good_log <- good_log[, -10]

log_xts <- xts::xts(good_log[,-1],
                    good_log$year_month)

ordered_depts <- names(sort(colSums(good_log[, -1],
                                    na.rm=TRUE)))


par(mfrow=c(5,3))
i <- 0 
for (dept in ordered_depts) {
    plot(log_xts[, dept], main=dept)
    i <- i + 1
    if (i %% 15 == 0) {
        Sys.sleep(5)
    }
}
par(mfrow=c(1,1))
plot(c())


plot(log_xts$zoning)
