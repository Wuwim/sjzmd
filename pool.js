//用户路由器
const mysql = require('mysql');
//创建连接对象
let pool = mysql.createPool({
    host: '127.0.0.1',
    port: '3307',
    user: 'root',
    password: '',
    database: 'sj',
    connectionLimit: 15,
    multipleStatements:true    //允许执行多条sql语句
});

//导出连接池对象
module.exports=pool;