//用户路由器
const express = require('express');
//引入连接池模块
const pool = require('../pool.js')

//创建路由器对象
let router = express.Router();

//挂载路由
//商品添加
router.post('/reg', (req, res) => {
	//获取表单数据
	let obj = req.body;
	//验证各项数据是否为空
	let i = 400;
	for (let key in obj) {
		i++;
		console.log(key, obj[key]); //key属性名， obj[key]属性值
		if (!obj[key]) {
			res.send({ code: i, msg: key + '为空' });
		}
	}
	pool.query('INSERT INTO sj_sj SET ?', [obj], (err, result) => {
		if (err) throw err;
		console.log(result);
		if (result.affectedRows > 0) {
			res.send({ code: 200, msg: '添加成功' });
		};
	});
});
//商品详情检索    get/detail
router.get('/detail', (req, res) => {
	var output = {
		details: {},
		family: {}
	};
	//获取数据，
	var obj = req.query;
	var $lid = obj.lid;
	if (!$lid) {
		res.send({ code: 401, msg: 'lid为空' });
		return;
	}
	//执行SQL语句，把查询的数据响应给浏览器
	pool.query('SELECT * FROM sj_sj WHERE lid=?', [$lid], (err, result) => {
		if (err) throw err;
		//判断数据是否为空
		if (result.length == 0) {
			res.send({ code: 301, msg: 'detail err' });
		} else {
			output.details = result[0];
			var lid = result[0].lid;
			var fid = result[0].family_id;
			var sql = `
		SELECT * FROM sj_sj_pic WHERE sj_id=? ORDER BY pid;
		SELECT * FROM sj_sj_family WHERE fid=?;
		SELECT lid,spec FROM sj_sj WHERE family_id=?;
		`;
			pool.query(sql, [lid, fid, fid], (err, result) => {
				output.details.picList = result[0];
				output.family = result[1][0];
				output.family.sjList = result[2];
			});

			setTimeout(() => {
				res.send(output);
			}, 100);

		}
	});
});
//商品列表
router.get('/list', (req, res) => {
	//获取数据
	var obj = req.query;
	var $pno = obj.pno;
	var $pageSize = obj.pageSize;
	//验证码页
	if (!$pno)
		$pno = 1;
	else
		$pno = parseInt($pno);
	//验证每页大小
	if (!$pageSize) {
		$pageSize = 9;
	} else {
		$pageSize = parseInt($pageSize);
	};
	var output = {
		recordCount: 0,
		pageSize: $pageSize,
		pageCount: 0,
		pno: $pno,
		data: []
	};
	var sql1 = 'SELECT COUNT(lid) AS a FROM sj_sj';
	//计算开始查询的值
	var start = ($pno - 1) * output.pageSize;
	var count = output.pageSize;
	var sql2 = 'SELECT lid,title,price,sold_count,is_onsale FROM sj_sj ORDER BY sold_count DESC LIMIT ?,?';
	//执行SQL语句,相应查询到的数据
	pool.query(sql1, (err, result) => {
		if (err) throw err;
		console.log(result);
		output.recordCount = result[0].a;
		//计算总页数
		output.pageCount = Math.ceil(output.recordCount / output.pageSize);
	});
	pool.query(sql2, [start, count], (err, result) => {
		if (err) throw err;
		console.log(result);
		output.data = result;
		for (var i = 0; i < output.data.length; i++) {
			var lid = output.data[i].lid;
			(function (lid, i) {
				pool.query('SELECT md FROM sj_sj_pic WHERE sj_id=? LIMIT 0,1', [lid], (err, result) => {
					output.data[i].pic = result[0].md;
				});
			})(lid, i);
		};
		setTimeout(() => {
			res.send(output);
		}, 100);
	});
});
//商品删除    get
router.get('/delect', (req, res) => {
	//获取表单数据
	let obj = req.query;
	//验证各项数据是否为空
	if (!obj.lid) {
		res.send({ code: 401, msg: 'ID为空' });
		//阻止往下执行
		return;
	}

	//执行sql语句
	pool.query('DELETE FROM sj_sj WHERE lid=?', [obj.lid], (err, result) => {
		if (err) throw err;
		console.log(result);
		//返回的是数组，如果查到相应的用户，数组中就会出现这条数据，否则没查找到，返回空数组
		if (result.affectedRows > 0) {
			res.send({ code: 200, msg: '商品删除成功' });
		} else {
			res.send({ code: 301, msg: '商品删除失败' });
		};
	});
});

//导出路由器对象
module.exports = router;

