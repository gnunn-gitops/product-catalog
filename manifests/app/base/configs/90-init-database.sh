init_database() {
    local thisdir
    local init_data_file
    thisdir=$(dirname ${BASH_SOURCE[0]})

    init_data_file=$(readlink -f ${thisdir}/../mysql-data/schema.sql)
    log_info "Initializing the database schema from file ${init_data_file}..."
    mysql $mysql_flags ${MYSQL_DATABASE} < ${init_data_file}

    init_data_file=$(readlink -f ${thisdir}/../mysql-data/import.sql)
    log_info "Initializing the database data from file ${init_data_file}..."
    mysql $mysql_flags ${MYSQL_DATABASE} < ${init_data_file}
}

if ! [ -v MYSQL_RUNNING_AS_SLAVE ] && $MYSQL_DATADIR_FIRST_INIT ; then
    init_database
fi
