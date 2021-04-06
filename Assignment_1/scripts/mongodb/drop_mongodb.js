
var db_name = ['db_100_1','db_100_2','db_100_3','db_1000_1','db_1000_2','db_1000_3','db_10000_1','db_10000_2','db_10000_3']

for(var i=0; i<9; ++i){
    print(`Dropping ${db_name[i]}..`)
    db = db.getSiblingDB(db_name[i])
    db.dropDatabase()
}