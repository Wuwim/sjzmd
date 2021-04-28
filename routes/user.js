//用户路由器
const express = require('express');
//引入连接池模块
const pool = require('../pool.js')

//创建路由器对象
let router = express.Router();

//挂载路由
//用户注册
router.post('/reg', (req, res) => {
	//获取表单数据
	let obj = req.body;
	//验证各项数据是否为空
	if (!obj.uname) {
		res.send({ code: 401, msg: '用户名为空' });
		//阻止往下执行
		return;
	}
	if (!obj.upwd) {
		res.send({ code: 402, msg: '密码为空' });
		//阻止往下执行
		return;
	}
	if (!obj.email) {
		res.send({ code: 403, msg: '邮箱为空' });
		//阻止往下执行
		return;
	}
	if (!obj.phone) {
		res.send({ code: 404, msg: '电话为空' });
		//阻止往下执行
		return;
	}
	pool.query('INSERT INTO sj_user SET ?', [obj], (err, result) => {
		if (err) throw err;
		console.log(result);
		if (result.affectedRows > 0) {
			res.send({ code: 200, msg: '注册成功' });
		};
	});
});
//用户登录
router.post('/login', (req, res) => {
	//获取表单数据
	let obj = req.body;
	//验证各项数据是否为空
	if (!obj.uname) {
		res.send({ code: 401, msg: '用户名为空' });
		//阻止往下执行
		return;
	}
	if (!obj.upwd) {
		res.send({ code: 402, msg: '密码为空' });
		//阻止往下执行
		return;
	}
	//执行sql语句
	pool.query('SELECT * FROM sj_user WHERE uname=? AND upwd=?', [obj.uname, obj.upwd], (err, result) => {
		if (err) throw err;
		console.log(result);
		//返回的是数组，如果查到相应的用户，数组中就会出现这条数据，否则没查找到，返回空数组
		if (result.length > 0) {
			req.session.loginUname = obj.uname;
			req.session.loginUid = result[0].uid;
			console.log(req.session);
			res.send({ code: 200, msg: '登录成功' });
		} else {
			res.send({ code: 301, msg: '登录失败' });
		};
	});
});
//用户检索    get/detail
router.get('/detail', (req, res) => {
	//获取表单数据
	let obj = req.query;
	//验证各项数据是否为空
	if (!obj.uid) {
		res.send({ code: 401, msg: 'ID为空' });
		//阻止往下执行
		return;
	}

	//执行sql语句
	pool.query('SELECT * FROM sj_user WHERE uid=?', [obj.uid], (err, result) => {
		if (err) throw err;
		console.log(result);
		//返回的是数组，如果查到相应的用户，数组中就会出现这条数据，否则没查找到，返回空数组
		if (result.length > 0) {
			res.send({
				code: 200,
				msg: '用户检索成功',
				data: result[0]
			});
		} else {
			res.send({ code: 301, msg: '用户检索失败' });
		};
	});
});
//修改用户信息
router.get('/update', (req, res) => {
	//获取数据
	let obj = req.query;
	console.log(obj);
	//验证数据是否为空，遍历对象，访问每个属性，如果属性值为空，提示属性名那一项是必须的
	let i = 400;
	for (let key in obj) {
		i++;
		console.log(key, obj[key]); //key属性名， obj[key]属性值
		if (!obj[key]) {
			res.send({ code: i, msg: key + '为空' });
		}
	}
	//执行SQL语句
	pool.query('UPDATE sj_user SET ? WHERE uid=?', [obj, obj.uid], (err, result) => {
		if (err) throw err;
		if (result.affectedRows > 0) {
			res.send({ code: 200, msg: '修改成功' });
		} else {
			res.send({ code: 301, msg: '修改失败' });
		}
	});
});
//用户列表
router.get('/list', (req, res) => {
	//获取数据
	let obj = req.query;
	console.log(obj);
	//验证数据是否为空，用默认值来实现
	if (!obj.pno) obj.pno = 1;
	if (!obj.count) obj.count = 2;
	//将count转换为整形
	obj.count = parseInt(obj.count);
	//计算 start
	let start = (obj.pno - 1) * obj.count;
	//执行SQL语句
	pool.query('SELECT * FROM sj_user limit ?,?', [start, obj.count], (err, result) => {
		if (err) throw err;
		console.log(result);
		//返回的是数组，如果查到相应的用户，数组中就会出现这条数据，否则没查找到，返回空数组
		if (result.length > 0) {
			res.send({
				code: 200,
				msg: '用户列表显示成功',
				data: result
			});
		} else {
			res.send({ code: 301, msg: '用户查询失败' });
		};
	});
});
//用户删除    get/detail
router.get('/delete', (req, res) => {
	//获取表单数据
	let obj = req.query;
	//验证各项数据是否为空
	if (!obj.uid) {
		res.send({ code: 401, msg: 'ID为空' });
		//阻止往下执行
		return;
	}

	//执行sql语句
	pool.query('DELETE FROM sj_user WHERE uid=?', [obj.uid], (err, result) => {
		if (err) throw err;
		console.log(result);
		//返回的是数组，如果查到相应的用户，数组中就会出现这条数据，否则没查找到，返回空数组
		if (result.affectedRows > 0) {
			res.send({ code: 200, msg: '用户删除成功' });
		} else {
			res.send({ code: 301, msg: '用户删除失败' });
		};
	});
});

//用户地址添加
router.post('/address', (req, res) => {
	var obj = req.body;
	var $aid = obj.aid;
	var $receiver = obj.receiver;
	var $province = obj.province;
	var $city = obj.city;
	var $county = obj.county;
	var $address = obj.address;
	var $cellphone = obj.cellphone;
	var $fixedphone = obj.fixedphone;
	var $postcode = obj.postcode;
	var $tag = obj.tag;
	var $is_default = obj.is_default;
	if (!req.session.loginUid) {
		res.send({ code: 300, msg: '用户未登录' });
		return;
	}
	let i = 400;
	for (let key in obj) {
		i++;
		console.log(key, obj[key]); //key属性名， obj[key]属性值
		if (!obj[key]) {
			res.send({ code: i, msg: key + '为空' });
		}
	}
	var sql = `INSERT sj_receiver_address SET user_id=?,aid=?,receiver=?,province=?,city=?,county=?,address=?,cellphone=?,fixedphone=?,postcode=?,tag=?,is_default=?`;
	pool.query(sql, [req.session.loginUid, $aid, $receiver, $province, $city, $county, $address, $cellphone, $fixedphone, $postcode, $tag, $is_default], (err, result) => {
		if (err) throw err;
		console.log(result);
		if (result.affectedRows > 0) {
			res.send({ code: 200, msg: '添加成功' });
		} else {
			res.send({ code: 301, msg: '添加失败' });
		};
	});
});

//查询用户地址
router.get('/ardetail', (req, res) => {
	if (!req.session.loginUid) {
		res.send({ code: 300, msg: '用户未登录' });
		return;
	}
	//执行sql语句
	pool.query('SELECT * FROM sj_receiver_address WHERE user_id=?', [req.session.loginUid], (err, result) => {
		if (err) throw err;
		console.log(result);
		//返回的是数组，如果查到相应的用户，数组中就会出现这条数据，否则没查找到，返回空数组
		if (result.length > 0) {
			res.send({
				code: 200,
				msg: '用户地址查询成功',
				data: result
			});
		} else {
			res.send({ code: 301, msg: '用户地址查询失败' });
		};
	});
});

//修改用户地址
router.get('/arupdate', (req, res) => {
	//获取数据
	let obj = req.query;
	if (!req.session.loginUid) {
		res.send({ code: 300, msg: '用户未登录' });
		return;
	}
	//验证数据是否为空，遍历对象，访问每个属性，如果属性值为空，提示属性名那一项是必须的
	let i = 400;
	for (let key in obj) {
		i++;
		console.log(key, obj[key]); //key属性名， obj[key]属性值
		if (!obj[key]) {
			res.send({ code: i, msg: key + '为空' });
		}
	}
	//执行SQL语句
	pool.query('UPDATE sj_receiver_address SET ? WHERE aid=? AND user_id=? ', [obj, obj.aid, req.session.loginUid], (err, result) => {
		if (err) throw err;
		if (result.affectedRows > 0) {
			res.send({ code: 200, msg: '修改成功' });
		} else {
			res.send({ code: 301, msg: '修改失败' });
		}
	});
});

//退出登录
router.get('/logout', (req, res) => {
	req.session.destroy();
	res.send({ code: 200, msg: '退出登录成功' });
});

//返回当前登录用户的信息
router.get('/sessiondata', (req, res) => {
	res.send({ uid: req.session.loginUid, uname: req.session.loginUname });
});



//导出路由器对象
module.exports = router;

