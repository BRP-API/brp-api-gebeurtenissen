CONTAINER_NAME="db"
DB_USER="root"
DB_NAME="rvig_haalcentraal_testdata"
DATA_FILE="scripts/sql/pl_en_adres.sql"
cat $DATA_FILE | docker exec -i --user $DB_USER $CONTAINER_NAME psql -U $DB_USER -d $DB_NAME