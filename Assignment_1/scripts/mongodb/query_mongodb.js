db.setProfilingLevel(0)
db.system.profile.drop()

var t_start
var t_end
var date_obj
// Query 1
print("\n\n=====================Query1=====================\n\n")
date_obj = new Date()
t_start = date_obj.getTime()

db.A.aggregate([
    {
        $match:{
            A1:{$lte:50}
        }
    }
]).forEach(printjson)

date_obj = new Date()
t_end = date_obj.getTime()
print("       millis", t_end-t_start)


// Query 2
print("\n\n=====================Query2=====================\n\n")
date_obj = new Date()
t_start = date_obj.getTime()

db.B.aggregate(
    [
        {$sort:{B3:1}}
    ], 
    {   
        allowDiskUse: true
    }
).forEach(printjson)

date_obj = new Date()
t_end = date_obj.getTime()
print("       millis", t_end-t_start)


// Query 3
print("\n\n=====================Query3=====================\n\n")
date_obj = new Date()
t_start = date_obj.getTime()

db.B.aggregate([
    {
        $group:{
            _id:"$B2",
            total:{$sum:1}
        }
    },
    {
        $group:{
            _id:null,
            avgVal:{$avg:"$total"}
        }
    }
]).forEach(printjson)

date_obj = new Date()
t_end = date_obj.getTime()
print("       millis", t_end-t_start)


// Query 4
print("\n\n=====================Query4=====================\n\n")
date_obj = new Date()
t_start = date_obj.getTime()

db.B.aggregate([
    {
        $lookup:{
            from:"A",
            localField:"B2",
            foreignField:"A1",
            as:"Ax"
        }
    },
    {
        $replaceRoot:{
            newRoot:{
                $mergeObjects:[
                    {
                        $arrayElemAt:["$Ax", 0]
                    },
                    "$$ROOT"
                ]
            }
        }
    },
    {
        $project:{Ax:0}
    }
]).forEach(printjson)

date_obj = new Date()
t_end = date_obj.getTime()
print("       millis", t_end-t_start)
