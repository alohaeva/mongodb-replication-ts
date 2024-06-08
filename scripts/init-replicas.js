var config = {
    "_id": "dbrs",
    "version": 1,
    "members": [
        {
            "_id": 1,
            "host": "mongo-rs1:27017",
            "priority": 2
        },
        {
            "_id": 2,
            "host": "mongo-rs2:27017",
            "priority": 1
        },
        {
            "_id": 3,
            "host": "mongo-rs3:27017",
            "priority": 1
        }
    ]
};
rs.initiate(config, { force: true });