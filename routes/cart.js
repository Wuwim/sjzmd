const express = require('express');
const pool = require('../pool.js');
var router = express.Router();
//1.添加购物车
router.get('/add', (req, res) => {
	var obj = req.query;
	var $product_id = obj.product_id;
	var $count = obj.count;
	if (!obj.product_id) {
		res.send({ code: 401, msg: '商品编号为空' });
		return;
	}
	if (!obj.count) {
		res.send({ code: 402, msg: '数量不能为空' });
		return;
	}
	if (!req.session.loginUid) {
		req.session.pageToJump = 'cart.html';
		req.session.toBuyproduct_id = obj.product_id;
		req.session.tocount = obj.count;
		res.send({ code: 300, msg: '用户未登录' });
		return;
	}
	var sql = `SELECT iid FROM sj_shopping_cart WHERE user_id=? AND product_id=?`;
	pool.query(sql, [req.session.loginUid, $product_id], (err, result) => {
		if (err) throw err;
		var sql2;
		if (result.length > 0) {
			sql2 = `UPDATE sj_shopping_cart SET count=count+${$count} WHERE user_id=${req.session.loginUid} AND product_id=${$product_id}`;

		} else {
			sql2 = `INSERT INTO sj_shopping_cart VALUES(NULL, ${req.session.loginUid}, ${$product_id}, ${$count}, false)`;
		}
		pool.query(sql2, (err, result2) => {
			if (err) throw err;
			if (result2.affectedRows > 0) {
				res.send({ code: 200, msg: '加入购物车成功' });
			} else {
				res.send({ code: 500, msg: '加入购物车失败' });
			}
		});
	});
});
//2.购物车列表
router.get('/list', (req, res) => {
	var output = {};
	if (!req.session.loginUid) {
		req.session.pageToJump = 'cart.html';
		res.send({ code: 300, msg: '用户未登录' });
		return;
	}
	var sql = 'SELECT iid,product_id,title,spec,price,count FROM sj_sj l, sj_shopping_cart s WHERE l.project_id=s.product_id AND user_id=?';
	pool.query(sql, [req.session.loginUid], (err, result) => {
		if (err) throw err;
		output.code = 200;
		output.data = result;
		for (var i = 0; i < output.data.length; i++) {
			var product_id = output.data[i].product_id;
			(function (product_id, i) {
				pool.query('SELECT sm FROM sj_sj_pic WHERE sj_id=? LIMIT 1', [product_id], (err, result) => {
					output.data[i].pic = result[0].sm;
				});
			})(product_id, i);
		}
		setTimeout(() => {
			res.send(output);
		}, 100);
	});
});
//3.删除购物车
router.get('/del', (req, res) => {
	var obj = req.query;
	if (!obj.iid) {
		res.send({ code: 401, msg: '购物车编号不能为空' });
		return;
	}
	if (!req.session.loginUid) {
		res.send({ code: 300, msg: '用户未登录' });
		return;
	}
	pool.query('DELETE FROM sj_shopping_cart WHERE iid=?', [obj.iid], (err, result) => {
		if (err) throw err;
		if (result.affectedRows > 0) {
			res.send({ code: 200, msg: '删除商品成功' });
		} else {
			res.send({ code: 500, msg: '删除商品失败' });
		}
	});
});

//4.修改商品购买数量
router.get('/updatecount', (req, res) => {
	var obj = req.query;
	if (!obj.iid) {
		res.send({ code: 401, msg: '购物车编号为空' });
		return;
	}
	if (!obj.count) {
		res.send({ code: 402, msg: '数量不能为空' });
		return;
	}
	if (!req.session.loginUid) {
		req.session.pageToJump = 'cart.html';
		res.send({ code: 300, msg: '用户未登录' });
		return;
	}
	var sql = `UPDATE sj_shopping_cart SET count = ? WHERE iid=?`;
	pool.query(sql, [obj.count, obj.iid], (err, result) => {
		if (err) throw err;
		if (result.affectedRows > 0) {
			res.send({ code: 200, msg: '修改成功' });
		} else {
			res.send({ code: 301, msg: '修改失败' });
		}
	});
});

//5.修改商品是否选中
router.get('/chose', (req, res) => {
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
	pool.query('UPDATE sj_shopping_cart SET is_checked=? WHERE iid=? AND user_id=? ', [obj, obj.iid, req.session.loginUid], (err, result) => {
		if (err) throw err;
		if (result.affectedRows > 0) {
			res.send({ code: 200, msg: '修改成功' });
		} else {
			res.send({ code: 301, msg: '修改失败' });
		}
	});
});


module.exports = router;